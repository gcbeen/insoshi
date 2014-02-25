# -*- encoding : utf-8 -*-
module LinksHelper

  def like_it_path(obj)
	send "like_it_#{obj.class.to_s.downcase}_path", obj
  end

  def like_link(obj)
	str = <<-DOC
		#{ link_to sanitize("<i class='icon-heart#{ current_user.is_like(obj) ? " like_red" : "" }'></i>"), like_it_path(obj), remote: true, method: :put, title: '喜欢' }
		#{ sanitize "<span class='like_count'>#{obj.likes.count}</span>人喜欢" }
	DOC
	str.html_safe
  end

  def favorite_path(obj)
	send "favorite_#{obj.class.to_s.downcase}_path", obj
  end

  def user_favable_path(favable)
	send "user_#{favable.class.to_s.downcase}_path", favable.user, favable
  end

  def favorite_link(obj)
	str = <<-DOC
		#{ link_to sanitize("<i class='icon-bookmark#{ current_user.favable?(obj) ? " favorite_red" : "" }'></i>"), favorite_path(obj), remote: true, method: :put, title: '收藏' }
		#{ sanitize "<span class='favorite_count'>#{obj.favorites.count}</span>人收藏" }
	DOC
	str.html_safe
  end

  def reply_link(obj)
	str = <<-DOC
	#{link_to sanitize("<i class='icon-comment'></i>"), 'javascript:void(0)', onclick: "reply('#{ obj.user.nickname}', '#{ obj.floor_num}', '#{profile_user_path(obj.user)}')", title: '回复'}
	<span>回复</span>
	DOC
	str.html_safe
  end

  def user_image_link(user, size = 80)
	link_to image_tag(user.avatar || user.gravatar_url(rating: 'R', secure: true), width: size, height: size), profile_user_path(user)
  end

  def edit_blog
	editable if @blog.user == current_user
  end

  def edit_topic
	editable if @topic.user == current_user
  end
  
  def editable
	str = <<-DOC
	#{link_to sanitize("<i class='icon-edit'></i>"), 'javascript:void(0)', id: 'edit', title: '编辑'}
	<span>编辑</span>
	DOC
	str.html_safe
  end

  def edit_comment(object, url)
	if object.user == current_user
	  str = <<-DOC
	  #{link_to sanitize("<i class='icon-edit'></i>"), 'javascript:void(0)', onclick: "edit_reply('reply-#{object.floor_num}', '#{url}' )", title: '编辑'}
	  <span>编辑</span>
	  DOC
	  str.html_safe
	end
  end

end
