# -*- encoding : utf-8 -*-
class BlogsController < ApplicationController

  def index
	@user = User.find(params[:user_id])
	@blogs = @user.blogs.paginate :page => params[:page], :per_page => APP_CONFIG[:per_page]
  end

  def new
    @blog = Blog.new
  end

  def create
	@blog = Blog.new(title: params[:blog][:title], content: params[:blog][:content])
	@blog.user = current_user
	if @blog.save
	  redirect_to user_blogs_path(current_user), notice: '发表成功' 
	else
	  render 'new'
	end
  end

  def show
	@user = User.find params[:user_id]
	@blog = @user.blogs.find(params[:id])
	@comments = @blog.root_comments.order(:floor_num).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
	@comment = Comment.new
  end

  def update
	@blog = Blog.find(params[:id])
	respond_to do |format|
	  if @blog.update_attributes(params[:blog])
	    format.html { redirect_to user_blog_path(current_user, @blog), notice: '修改博文成功' }
	    format.json { render json: @blog  }
	  else
	    format.html { render action: 'edit' }
	    format.json { render json: @blog.errors, status: :unprocessable_entity }
	  end
	end
  end

  def like_it
	@blog = Blog.find(params[:id])
	current_user.is_like(@blog) ? current_user.dislike(@blog) : current_user.like(@blog)
	#respond_to do |format|
	#  format.json { render json: @blog }
	#end
  end

  def favorite
	@blog = Blog.find params[:id]
	current_user.favable?(@blog) ? current_user.unfavable(@blog) : current_user.favable(@blog)
  end

  def reply
	@blog = Blog.find(params[:id])
	@comment = Comment.build_from(@blog, current_user.id, params[:comment][:body])
	@comment.save
	respond_to do |format|
	  format.html
	  format.js
	end
  end

  def edit_reply
  	@comment = Comment.find_comment(params[:id], current_user, 'Blog', params[:blog_id])
	respond_to do |format|
	  if @comment.update_attributes(params[:comment])
	    format.json { render json: @comment }
	  else
	    format.json { render json: @comment.errors, status: :unprocessable_entity }
	  end
	end
  end

end
