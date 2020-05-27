json.array! @notifications do |notification|
  #json.receiver notification.receiver
  json.actor notification.actor.email
  json.action notification.action
  json.notifiable do #notification.notifiable
    json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
end