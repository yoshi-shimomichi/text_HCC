class ProfilesController < ApplicationController
    before_action :set_user, only: %i[edit update]
  
    def show
      @questions = Post.where(user_id: current_user.id, post_type: :question)
      @tweets = Post.where(user_id: current_user.id, post_type: :tweet)
      @comments = Comment.where(user_id: current_user.id)
      @favorite_posts = current_user.favorite_posts.includes(:user).order(created_at: :desc)
      @favorite_comments = current_user.favorite_comments.includes(:user).order(created_at: :desc)
    end
  
    def edit; end
  
    def update
      if @user.update(user_params)
        redirect_to profile_path, success: t('profiles.update.success', item: User.model_name.human)
      else
        flash.now[:danger] = t('profiles.update.failure', item: User.model_name.human)
        render :edit, status: :unprocessable_entity
      end
    end
  
    def questions
      @posts = Post.where(user_id: current_user.id, post_type: :question)
    end
  
    def tweets
      @posts = Post.where(user_id: current_user.id, post_type: :tweet)
    end
  
    def comments
      @comments = Comment.where(user_id: current_user.id)
    end
  
    def favorite_posts
      @posts = current_user.favorite_posts.includes(:user).order(created_at: :desc)
    end
  
    def favorite_comments
      @comments = current_user.favorite_comments.includes(:user).order(created_at: :desc)
    end
  
    private
  
    def set_user
      @user = User.find(current_user.id)
    end
  
    def user_params
      params.require(:user).permit(:email, :name, :bio, :avatar, :avatar_cache)
    end
  end