class Order < ActiveRecord::Base
	  has_and_belongs_to_many :users , dependent: :destroy
	    enum for: [ :breakfast, :launch ]
	    enum status: [ :waiting, :finished ]


end
