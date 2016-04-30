class NotificationsController < ApplicationController
	before_action :authenticate_user!

	def index
		@notifications = Notification.where(recipient: current_user, remove: false).limit(5)
		@number = Notification.where(recipient: current_user).unread.count
	end

	def mark_as_read
		@notifications = Notification.where(recipient: current_user).unread
		@notifications.update_all(read_at: Time.zone.now)
		render json: {success: true}
	end

	def make_join
		@notifications = Notification.where(id: params[:n_id])
		@notifications.update_all(remove: true)
		Notification.create(recipient: User.find(params[:id]), actor: current_user, action: "has joined", notifiable: Order.find(params[:order_id]), remove: false)
		OrdersUser.where(order_id: params[:order_id], user_id: current_user.id).update_all(is_joined: true)

		render json: {success: true}
	end

	def show
		@notifications = Notification.where(recipient: current_user)
	end

end
