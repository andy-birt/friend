class NotificationsController < ApplicationController
  
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(receiver: current_user)
  end

end