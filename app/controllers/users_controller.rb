# -*- encoding : utf-8 -*-
class UsersController < ApplicationController

  def profile
    @user = User.find(params[:id])
  end

  def change_info
    @user = User.find params[:id]
	return if request.get?
	@user.attributes = {email: params[:email], nickname: params[:nickname], city: params[:city], signature: params[:signature], introduction: params[:introduction]}
	redirect_to user_path, notice: '个人信息更新成功' if @user.save
  end

end
