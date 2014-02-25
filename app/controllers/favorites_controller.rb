# -*- encoding : utf-8 -*-
class FavoritesController < ApplicationController
  def index
	@user = User.find params[:user_id]
	@blog_favables = @user.favables('Blog')
	@topic_favables = @user.favables('Topic')
  end
end
