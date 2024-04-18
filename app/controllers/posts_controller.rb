class PostsController < ApplicationController
    before_action :set_post, only: %i[edit update destroy]
    before_action :set_tags, only: %i[index search]
    skip_before_action :require_login, only: %i[index show search autocomplete_word]
  
    def index
       @posts = Post.includes(:user).order(created_at: :desc).page(params[:page]).per(5)
    end
  
    def show
      @post = Post.find(params[:id])
      @comment  = Comment.new
      @comment_reply = Comment.new
      @comments = @post.comments.includes(:user).where(parent_id: nil)
      @comments_count = @post.comments.includes(:user).count
    end
  
    def new
      @post = Post.new
    end
  
    def edit
      @post = Post.find(params[:id])
      @tag_list = @post.tags.pluck(:name).join(' ')
    end
  
    def create
      @post = current_user.posts.build(post_params)
      tag_list = params[:post][:name].split(/[[:blank:]]+/)  
      if @post.save
        @post.save_tag(tag_list)
        redirect_to posts_path, success: t('.success', item: Post.model_name.human)
      else
        flash.now[:danger] = t('.failure', item: Post.model_name.human)
        @tag_list = tag_list.join(' ')
        render :new, status: :unprocessable_entity
      end
    end
  
    def update
      @post = Post.find(params[:id])
      tag_list = params[:post][:name].split
      if @post.update(post_params)
        @post.save_tag(tag_list)
        redirect_to post_path(@post), success: t('.success')
      else
        flash.now[:danger] = t('.failure')
        @tag_list = tag_list.join(' ')
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @post = Post.find(params[:id])
      @post.destroy!
      redirect_to posts_path, success: t('.success'), status: :see_other
    end
  
    def search
      redirect_to posts_path if params[:keyword].blank? && params[:post_type].blank?
      keyword_result = []
      i = 1
      unless params[:keyword].blank?
        keyword_array = params[:keyword].split(/[[:blank:]]+/)        
        keyword_array.each do |keyword|
          next if keyword.blank?
          post_ids = Post.where('body LIKE ?', "%#{keyword}%").pluck(:id)
          tag_ids = Tag.where('name LIKE ?', "#{keyword}").pluck(:id)
          post_tag_ids = PostTag.where(tag_id: tag_ids).pluck(:post_id)
          keyword_array = post_ids | post_tag_ids
          if i == 1
            keyword_result += keyword_array
          else
            keyword_result &= keyword_array
          end
          i += 1
        end
      else
        keyword_result = Post.all.pluck(:id)
      end
  
      select_post_type = params[:post_type].blank? ? Post.all.pluck(:id) : Post.where(post_type: params[:post_type]).pluck(:id)
      result = keyword_result & select_post_type
      @posts = Post.includes(:user).where(id: result).order(created_at: :desc)
    end
  
    def autocomplete_word
      @tags = Tag.where("name LIKE ?", "%#{params[:q]}%").limit(10)
      respond_to do |format|
        format.js
      end
    end
  
    private
  
    def post_params
      params.require(:post).permit(:post_type, :body, :post_image, :post_image_cache, :remove_post_image)
    end
  
    def set_post
      @post = current_user.posts.find(params[:id])
    end
  
    def set_tags
      @tags = Tag.all
    end
  end