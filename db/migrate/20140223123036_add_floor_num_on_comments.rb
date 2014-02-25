# -*- encoding : utf-8 -*-
class AddFloorNumOnComments < ActiveRecord::Migration
  def up
	add_column :comments, :floor_num, :integer
	Comment.set_floor_num
  end

  def down
	remove_column :comments, :floor_num
  end
end
