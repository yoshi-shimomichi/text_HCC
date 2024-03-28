class UsersController < ApplicationController
    skip_before_action :require_login, only: %i[new create]
  
    def new
      @user = User.new
      @user.build_care_person
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        login(user_params[:email], user_params[:password])
        redirect_to root_path, success: t('users.create.success')
      else
        flash.now[:danger] = t('users.create.failure')
        render :new, status: :unprocessable_entity
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name, :bio, :avatar, 
        care_person_attributes: [:id, :age, :sex, :care_level, :bio])
    end
  end
  