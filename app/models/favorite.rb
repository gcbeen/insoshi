# -*- encoding : utf-8 -*-
class Favorite < ActiveRecord::Base

  include ActsAsFavable::Favorite

  belongs_to :favable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: Favorite belongs to a user
  belongs_to :user

  class << self
    def favables(type)
      where(favable_type: type).map(&:favable)
    end

	def favable(obj)
	  where(favable_type: obj.class.to_s, favable_id: obj.id).first
	end
  end

end
