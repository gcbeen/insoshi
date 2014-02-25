# -*- encoding : utf-8 -*-
class AddCommentsCountOnBlog < ActiveRecord::Migration
  def up
	add_column :blogs, :comments_count, :integer, default: 0
	Blog.set_comments_count
  end

  def down
	remove_column :blogs, :comments_count
  end
end
