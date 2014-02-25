# -*- encoding : utf-8 -*-
class TopicsController < ApplicationController

  def index
	@user = User.find(params[:user_id])
	@topics = @user.topics.paginate :page => params[:page], :per_page => APP_CONFIG[:per_page]
  end

  def new
    @topic = Topic.new
  end

  def create
	@topic = Topic.new(title: params[:topic][:title], content: params[:topic][:content])
	@topic.user = current_user
	if @topic.save
	  redirect_to user_topics_path(current_user), notice: '发表成功' 
	else
	  render 'new'
	end
  end

  def show
	@user = User.find params[:user_id]
	@topic = @user.topics.find(params[:id])
	@comments = @topic.root_comments.order(:floor_num).paginate(:page => params[:page], :per_page => APP_CONFIG[:per_page])
	@comment = Comment.new
  end

  def update
	@topic = Topic.find(params[:id])
	respond_to do |format|
	  if @topic.update_attributes(params[:topic])
	    format.html { redirect_to user_topic_path(current_user, @topic), notice: '修改博文成功' }
	    format.json { render json: @topic  }
	  else
	    format.html { render action: 'edit' }
	    format.json { render json: @topic.errors, status: :unprocessable_entity }
	  end
	end
  end

  def like_it
	@topic = Topic.find(params[:id])
	current_user.is_like(@topic) ? current_user.dislike(@topic) : current_user.like(@topic)
	#respond_to do |format|
	#  format.json { render json: @topic }
	#end
  end

  def favorite
	@topic = Topic.find params[:id]
	current_user.favable?(@topic) ? current_user.unfavable(@topic) : current_user.favable(@topic)
  end

  def reply
	@topic = Topic.find(params[:id])
	@comment = Comment.build_from(@topic, current_user.id, params[:comment][:body])
	@comment.save
	respond_to do |format|
	  format.html
	  format.js
	end
  end

  def edit_reply
  	@comment = Comment.find_comment(params[:id], current_user, 'Topic', params[:topic_id])
	respond_to do |format|
	  if @comment.update_attributes(params[:comment])
	    format.json { render json: @comment }
	  else
	    format.json { render json: @comment.errors, status: :unprocessable_entity }
	  end
	end
  end

end
