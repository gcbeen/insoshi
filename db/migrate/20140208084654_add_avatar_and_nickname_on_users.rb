# -*- encoding : utf-8 -*-
class AddAvatarAndNicknameOnUsers < ActiveRecord::Migration
  def up
	add_column :users, :avatar, :string
	add_column :users, :nickname, :string
  end

  def down
	remove_column :users, :avatar
	remove_column :users, :nickname
  end
end
