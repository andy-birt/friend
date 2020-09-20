class Photos::LikesController < LikesController
  before_action :set_likable

  private

    def set_likable
      @likable = Photo.find(params[:photo_id])
    end
end