json.array! @notifications do |notification|
	#json.recipient notification.recipient
	json.actor notification.actor.name
	json.action notification.action
	json.notifiable do 
		json.type "to an #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
	end
	json.url order_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end