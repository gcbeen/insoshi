# -*- encoding : utf-8 -*-
module OmniauthLinkHelper
  def omniauth_link(resource_name, provider)
	str = <<-DOC
	<a href='#{ omniauth_authorize_path(resource_name, provider) }' class='btn btn-social btn-block btn-#{ t ".#{provider}" }' >
	  <i class='fa fa-#{t ".#{provider}" }'></i>#{ t 'omniauth_text', provider_name: t(".#{provider}_text") }
	</a>
	DOC
	str.html_safe
  end
end

