# -*- encoding : utf-8 -*-
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def google_oauth2
	omniauth_callback('Google Oauth2')
  end 

  def google
	omniauth_callback('Google')
  end

  def github
	omniauth_callback('Github')
  end

  def weibo
	omniauth_callback('Weibo')
  end


  def qq_connect
	omniauth_callback('QQ')
  end

  def tqq
	omniauth_callback('TQQ')
  end

  private

  def omniauth_callback(kind)
    user = User.from_omniauth(env["omniauth.auth"])
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => kind
      sign_in_and_redirect user
    else
      session["devise.user_attributes"] = user.attributes
      flash.notice = "您是新用户，请先设置密码完成帐号设置"
      redirect_to new_user_registration_url
    end
  end

end
