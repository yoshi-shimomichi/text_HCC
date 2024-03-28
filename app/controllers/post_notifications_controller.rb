class PostNotificationsController < ApplicationController
	def index
    post_notifications = current_user.post_passive_notifications.where(checked: false)
    comment_notifications = current_user.comment_passive_notifications.where(checked: false)
    @notifications = post_notifications | comment_notifications
    @notifications = @notifications.select { |notification| notification.visitor_id != current_user.id }
  end

  def checked_all
    post_notifications = current_user.post_passive_notifications.where(checked: false)
    comment_notifications = current_user.comment_passive_notifications.where(checked: false)
    @notifications = post_notifications | comment_notifications
    @notifications.each do |notification|
      notification.update(checked: true)
    end
    redirect_to post_notifications_path
  end

  def checked
    @notification = PostNotification.find(params[:id])
    @notification.update(checked: true)
    redirect_to post_notifications_path
  end
end
