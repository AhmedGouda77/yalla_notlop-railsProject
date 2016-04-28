class Order < ActiveRecord::Base
	include PublicActivity::Common
	has_many :order_details
	  has_and_belongs_to_many :users , dependent: :destroy
	    enum for: [ :breakfast, :launch ]
	    enum status: [ :waiting, :finished ]
	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
