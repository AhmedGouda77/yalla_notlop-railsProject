class Order < ActiveRecord::Base

	include PublicActivity::Common

	has_many :order_details, dependent: :destroy
	  has_and_belongs_to_many :users , dependent: :destroy
	    enum for: [ :breakfast, :launch ]
	    enum status: [ :waiting, :finished ]
         
        def self.currentUserOrders(currentUserId)
        a = Order.all.where(user_id: currentUserId  )
        end
        def self.getOrderDetails(orderId)
        a = Order.all.where(id: orderId )
        end

end


	




