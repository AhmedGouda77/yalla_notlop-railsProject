class OrdersUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  
        def self.joinedOrders(currentUserID)
        a = OrdersUser.all.where(user_id: currentUserID).where(is_joined: 1)
        end
        def self.countInvited(orderID)
        a = OrdersUser.all.where(order_id: orderID).count
        end
        def self.countJoined(orderID)

        a = OrdersUser.all.where(order_id: orderID).where(is_joined: 1).count
        end
end
