module PostsHelper
  def char_count_high_for(post)
    post[400..-1]
  end

  def current_user_and_friends
    users = [current_user]
    current_user.friends.each do |friend|
      users << friend
    end
    users
  end
end
