class CommentsController < ApplicationController
    before_action :set_comment, only: %i[update destroy]
    before_action :set_post, only: %i[create update destroy]
  
  
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

    def update
      if @comment.update(comment_params)
        redirect_to post_path(@comment.post_id), success: t('.success', item: Comment.model_name.human)
      end
    end
  
    def destroy
      @comment.destroy!
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