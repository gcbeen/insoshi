# -*- encoding : utf-8 -*-
class Blog < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title, :content, :likeable
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  
  acts_as_likeable
  acts_as_favable
  acts_as_commentable
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  def self.activity(activities)
	activities.where(trackable_type: 'Blog').map(&:trackable)
  end

  def self.set_comments_count
	Blog.all.map do |blog|
	  blog.update_attribute(:comments_count, blog.root_comments.count)
	end
  end

end
