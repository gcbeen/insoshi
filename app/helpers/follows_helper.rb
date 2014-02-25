# -*- encoding : utf-8 -*-
module FollowsHelper
  def array_split(array, element = 4)
	new_array = []

	while array != []
	  new_array << array.shift(element)
	end
	new_array
  end

  def followings
  	current_user.following_users.limit 12
  end

  def followers
    current_user.user_followers.limit 12
  end

  def to_followings
    User.all.reject{|user| user == current_user || current_user.following?(user) }.slice(0, 12)
  end

end
