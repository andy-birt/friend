class Photos::CommentsController < CommentsController
  before_action :set_commentable

  def index
    @commentable = set_commentable
    @comments = @commentable.comments
  end

  private

    def set_commentable
      @commentable = Photo.find(params[:photo_id])
    end
end