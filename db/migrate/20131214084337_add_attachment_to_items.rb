# -*- encoding : utf-8 -*-
class AddAttachmentToItems < ActiveRecord::Migration
  def change
    add_attachment :items, :avatar
  end
end
