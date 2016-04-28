class Group < ActiveRecord::Base
	belongs_to :user
	acts_as_followable

	def self.all_group(user_id)
		where(" user_id = ?", "#{user_id}")
		
	end
end