
module PostNotificationsHelper
    def unchecked_notifications
      post_notifications = current_user.post_passive_notifications.where(checked: false)
      comment_notifications = current_user.comment_passive_notifications.where(checked: false)
      @notifications = post_notifications | comment_notifications
    end
  end
