# -*- encoding : utf-8 -*-
class AddInfoColumnsOnUsers < ActiveRecord::Migration
  def up
	add_column :users, :signature, :string
	add_column :users, :city,      :string
	add_column :users, :introduction, :string
  end

  def down
	remove_column :users, :signature
	remove_column :users, :city
	remove_column :users, :introduction
  end
end
