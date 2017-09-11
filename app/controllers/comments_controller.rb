class CommentsController < ApplicationController

  before_action :authenticate_user!
  # skip_before_action :authenticate_user!, only: [:create, :update, :destroy]

  before_action :fetch_user_or_guest, only: [:create, :update, :destroy]
  before_action :fetch_comment, only: [:destroy, :update]
  # after_filter :track_user_custom_fields, only: [:create, :update, :destroy]

  def create
    @comment = @commenter.comments.build(comment_params)
    send_conditional_json_response(@comment.save)
  end

  def update
    send_conditional_json_response(@comment.update(comment_params))
  end

  def destroy
    send_conditional_json_response(@comment.destroy)
  end

  def index
    @comments = Comment.by_commentable_id(params[:commentable_id]).by_commentable_type(params[:commentable_type])
    @commentable_type = @comments.first.commentable_type
    @commentable_id = @comments.first.commentable_id
    @users = User.pluck(:email).map(&:strip)
    respond_to do |format|
      format.js do
        render :nothing => true, :status => 200
      end
    end
  end

  private

    def send_conditional_json_response(condition)
      if condition
        render json: @comment.as_json, status: 200
      else
        render json: t('.failure', scope: :flash) , status: 422
      end
    end

    def fetch_comment
      unless @comment = @commenter.comments.find_by(id: params[:id])
        render json: t('.not_found', scope: :flash) , status: 404
      end
    end

    def comment_params
      params.require(:comment).permit(:message, :commentable_id, :commentable_type)
    end

    def fetch_user_or_guest
      unless @commenter = current_user
        render json: 'Not Authorized' , status: 403
      end
    end
end
