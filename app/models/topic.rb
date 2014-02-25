# -*- encoding : utf-8 -*-
class Topic < ActiveRecord::Base
  # attr_accessible :title, :body
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
	activities.where(trackable_type: 'Topic').map(&:trackable)
  end

end
