class CommentFavoritesController < ApplicationController
    def create
      @comment = Comment.find(params[:comment_id])
      current_user.comment_favorite_join(@comment)
      @comment.create_notification_favorite(current_user)
    end
  
    def destroy
      @comment = current_user.comment_favorites.find(params[:id]).comment
      current_user.comment_favorite_remove(@comment)
    end
  end
  