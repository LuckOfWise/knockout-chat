class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.js { render }
        format.json { render :show, status: :created, location: @comment }
      else
        format.js { head :no_content }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.js { head :no_content }
      format.json { head :no_content }
    end
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
