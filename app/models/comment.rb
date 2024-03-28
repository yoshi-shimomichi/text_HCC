class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    belongs_to :parent, class_name: "Comment", optional: true
    has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
    has_many :comment_favorites, dependent: :destroy
    has_many :comment_notifications, dependent: :destroy
  
    mount_uploader :comment_image, AvatarUploader
  
    validates :body, length: { maximum: 65_535 }, presence: true
  
    def comment_favorited_by?(user)
      comment_favorites.where(user_id: user).exists?
    end
  
    def create_notification_favorite(current_user)
      temp = CommentNotification.where(visitor_id: current_user.id, visited_id: user_id, comment_id: id, action: :favorite)
      if temp.blank?
        notification = current_user.comment_active_notifications.new(
          comment_id: id,
          visited_id: user_id,
          action: :favorite
        )
        notification.checked = true if notification.visitor_id == notification.visited_id
        notification.save if notification.valid?
      end
    end
  
    def create_notification_reply(current_user)
      parent_comment = Comment.find_by(id: parent_id)
      return unless parent_comment
  
      notification = current_user.comment_active_notifications.new(
        comment_id: id,
        visited_id: parent_comment.user_id,
        action: :comment
      )
      notification.checked = true if notification.visitor_id == notification.visited_id
      notification.save if notification.valid?
    end
  end
  