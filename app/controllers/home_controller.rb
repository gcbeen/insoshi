# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  def index
	@blog_activities = Blog.activity(current_user.following_activity)
	@topic_activities = Topic.activity(current_user.following_activity)
	@blog_activities = Blog.activity(PublicActivity::Activity) if @blog_activities.blank?
	@topic_activities = Topic.activity(PublicActivity::Activity) if @topic_activities.blank?
  end

end
