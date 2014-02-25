# -*- encoding : utf-8 -*-
module UsersHelper
  def user_item(item)
	"<dt>#{t ".#{item}"}</dt><dd>#{item}</dd>"
  end
end
