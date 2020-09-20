class Posts::CommentsController < CommentsController
  before_action :set_commentable

  def index
    @commentable = set_commentable
    @comments = @commentable.comments
  end

  private

    def set_commentable
      @commentable = Post.find(params[:post_id])
    end
end