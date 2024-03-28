class CommentsController < ApplicationController
    before_action :set_comment, only: %i[edit update destroy]
    before_action :set_post, only: %i[create edit update destroy]
  
    def new
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:parent_id])
      @comment_reply = Comment.new
  
      @comment_reply.user_id = current_user.id
      @comment_reply.post = @post
      @comment_reply.parent_id = @comment.id
    end
  
    def create
      @comment = current_user.comments.build(comment_params)
  
      if @comment.body.blank? && @comment.parent_id.present?
        flash[:danger] = "コメント返信できませんでした。"
        redirect_to post_path(@post)
      end
  
      if @comment.save
        @post.create_notification_comment(current_user)
        @comment.create_notification_reply(current_user) unless @comment.parent_id.nil?
        redirect_to post_path(@post)
      end
    end
  
    def edit; end
  
    def update
      if @comment.update(comment_params)
        redirect_to post_path(@comment.post_id), success: t('.success', item: Comment.model_name.human)
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment.destroy!
    end
  
    def reply_new
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:parent_id])
      @comment_reply = Comment.new
  
      @comment_reply.user_id = current_user.id
      @comment_reply.post = @post
      @comment_reply.parent_id = @comment.id
    end
  
    def reply_create
      @post = Post.find(params[:post_id])
      @comment = @post.comments
      @comment_reply = @comment.new(comment_params)
  
      @comment_reply.user_id = current_user.id
      @comment_reply.post = @post
      @comment_reply.parent_id = @comment.id
      
      if @comment_reply.save
        redirect_to post_path(@post)
      else
        render :new
      end
    end
      
    private
  
    def set_post
      @post = Post.find_by(id: params[:post_id])
    end
  
    def set_comment
      @comment = Comment.find(params[:id])
    end
  
    def comment_params
      params.require(:comment).permit(:body, :comment_image, :comment_image_cache, :remove_comment_image, :parent_id).merge(post_id: params[:post_id])
    end
  end