class Posts::LikesController < LikesController
  before_action :set_likable

  private

    def set_likable
      @likable = Post.find(params[:post_id])
    end
end