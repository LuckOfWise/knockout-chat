class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.order(created_at: :desc).limit(10)
  end

  def show
    respond_to :json
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render
    else
      head :no_content
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.fetch(:comment, {}).permit(:name, :content)
  end
end
