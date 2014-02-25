# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: items
#
#  id                  :integer          not null, primary key
#  title               :string(255)
#  description         :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#

class Item < ActiveRecord::Base
  attr_accessible :description, :title, :avatar
  validates :title, :presence => true

  has_attached_file :avatar, 
	  :styles => {:medium => "300x300>", :thumb => "100x100>"}, 
	  :default_url => "/images/:style/missing.png"

  validates_attachment :avatar, :presence => true,
	  :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/png"] },
	  :size => { :in => 0..1000.kilobytes }

  def before_destroy
	avatar = nil
  end

end
