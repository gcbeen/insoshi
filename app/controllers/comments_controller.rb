# -*- encoding : utf-8 -*-
class CommentsController < ApplicationController

  def index
	@user = User.find(params[:user_id])
	@blog_comments = Comment.find_blog_comments @user
	@topic_comments = Comment.find_topic_comments @user
  end
  
  def like_it
    @comment = Comment.find params[:id]
	current_user.is_like(@comment) ? current_user.dislike(@comment) : current_user.like(@comment)
  end

  def change
	@user = User.find params[:user_id]
	@blog = Blog.find params[:blog_id]
	@comment = Comment.find_comment(params[:id], current_user, 'Blog', @blog.id) if @user == current_user
	respond_to do |format|
	  if @comment.update_attribute(:body, params[:comment][:body])
	    format.js
      else
		format.json { render json: @comment.errors, status: :unprocessable_entity }
	  end
	end
  end

  def modify
	@user = User.find params[:user_id]
	@topic = Topic.find params[:topic_id]
	@comment = Comment.find_comment(params[:id], current_user, 'Topic', @topic.id) if @user == current_user
	respond_to do |format|
	  if @comment.update_attribute(:body, params[:comment][:body])
	    format.js
      else
		format.json { render json: @comment.errors, status: :unprocessable_entity }
	  end
	end
  end

end
