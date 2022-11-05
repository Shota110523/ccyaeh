class Public::NotificationsController < ApplicationController

  def index
    #current_customerの投稿に紐づいた通知一覧
	@notifications = current_customer.passive_notifications
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
	@notifications.where(checked: false).each do |notification|
  	  notification.update(checked: true)
    end
  end

  def destroy_all
    #通知を全削除
  	@notifications = current_customer.passive_notifications.destroy_all
  	redirect_to public_notifications_path
  end
end
