class PostFavoritesController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      current_user.post_favorite_join(@post)
      @post.create_notification_favorite(current_user)
    end
  
    def destroy
      @post = current_user.post_favorites.find(params[:id]).post
      current_user.post_favorite_remove(@post)
    end
  end
  