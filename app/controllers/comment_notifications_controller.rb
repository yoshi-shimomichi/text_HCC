class CommentNotificationsController < ApplicationController
    def checked
      @notification = CommentNotification.find(params[:id])
      @notification.update(checked: true)
      redirect_to post_notifications_path
    end
  end