# -*- encoding : utf-8 -*-
class Comment < ActiveRecord::Base
  
  before_create :set_floor_num

  acts_as_nested_set :scope => [:commentable_id, :commentable_type]

  acts_as_likeable

  validates :body, :presence => true
  validates :user, :presence => true

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_votable

  belongs_to :commentable, :polymorphic => true, :counter_cache => true, :touch => true

  # NOTE: Comments belong to a user
  belongs_to :user

  attr_accessible :body, :commentable, :user_id


  # Helper class method that allows you to build a comment
  # by passing a commentable object, a user_id, and comment text
  # example in readme
  def self.build_from(obj, user_id, comment)
    new \
      :commentable => obj,
      :body        => comment,
      :user_id     => user_id
  end

  #helper method to check if a comment has children
  def has_children?
    self.children.any?
  end

  # Helper class method to lookup all comments assigned
  # to all commentable types for a given user.
  scope :find_comments_by_user, lambda { |user|
    where(:user_id => user.id).order('created_at DESC')
  }

  # Helper class method to look up all comments for
  # commentable class name and commentable id.
  scope :find_comments_for_commentable, lambda { |commentable_str, commentable_id|
    where(:commentable_type => commentable_str.to_s, :commentable_id => commentable_id).order('created_at DESC')
  }

  def self.find_comment(id, user, commentable_type, commentable_id)
	find_comments_by_user(user).find_comments_for_commentable(commentable_type, commentable_id).find(id)
  end

  def self.find_comments_by_user_for_commentable(user, commentable_type)
	find_comments_by_user(user).where(commentable_type: commentable_type)
  end

  def self.find_blog_comments(user)
	find_comments_by_user_for_commentable user, 'Blog'
  end

  def self.find_topic_comments(user)
	find_comments_by_user_for_commentable user, 'Topic'
  end

  # Helper class method to look up a commentable object
  # given the commentable class name and id
  def self.find_commentable(commentable_str, commentable_id)
    commentable_str.constantize.find(commentable_id)
  end

  def self.set_floor_num
	Blog.all.each do |blog|
	  index = 0
	  blog.root_comments.order(:created_at).map do |comment|
		comment.update_attribute(:floor_num, index + 1)
		index += 1
	  end
	end
  end

  private
  def set_floor_num
	self.floor_num = self.commentable.comments_count + 1
  end

end
