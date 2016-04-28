class OrderDetail < ActiveRecord::Base
       belongs_to :order
       
	validates :item,
            presence: true
	validates :amount,
            presence: true
	validates :price,
            presence: true
end
