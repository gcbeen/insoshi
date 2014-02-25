# -*- encoding : utf-8 -*-
module ShowsHelper
  def last_reply(obj)
	comment = obj.root_comments.last
	sanitize "最后由#{ link_to comment.user.nickname, profile_user_path(comment.user)}于#{times_ago comment.created_at}回复" if comment
  end

  def publish(obj)
	sanitize "#{link_to obj.user.nickname, profile_user_path(obj.user)}于#{times_ago obj.created_at}发布"
  end

  def times_ago(time)
    sanitize "#{distance_of_time_in_words time, Time.zone.now}前"
  end
end

