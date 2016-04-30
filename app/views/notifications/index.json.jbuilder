json.array! @notifications do |notification|
	#json.recipient notification.recipient

	json.number @number.to_i
	json.nid notification.id
	json.actor notification.actor
	json.action notification.action
	json.order notification.notifiable

	json.notifiable do 
		json.type "#{notification.notifiable.class.to_s.underscore.humanize.downcase}"
	end
	json.url order_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end
