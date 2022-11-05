module Public::NotificationsHelper

  def notification_form(notification)
	  @visiter = notification.visiter
	  @visiter_comment = notification.comment_id
	  #notification.actionがfollowかlikeかcommentか
	  case notification.action
	    when "follow" then
	      tag.a(notification.visiter.name, href:public_customer_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
	    when "favorite" then
	      tag.a(notification.visiter.name, href:public_customer_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:public_post_path(notification.post_id), style:"font-weight: bold;")+"にいいねしました"
	    when "comment" then
	    	tag.a(@visiter.name, href:public_customer_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:public_post_path(notification.post_id), style:"font-weight: bold;")+"にコメントしました"
	  end
	end

	def unchecked_notifications
    @notifications = current_customer.passive_notifications.where(checked: false)
  end
end
