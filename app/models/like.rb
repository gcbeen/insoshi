# -*- encoding : utf-8 -*-
class Like < ActiveRecord::Base
  belongs_to :liker, :polymorphic => true
  belongs_to :likeable, :polymorphic => true
  validates_uniqueness_of :liker_id, :scope => [:liker_type, :likeable_id, :likeable_type]
  attr_accessible :likeable

  class << self	
    def likes_on(likeable)
        where(["likeable_id = ? AND likeable_type = ?", likeable.id, likeable.class.name])
    end
  end
end
