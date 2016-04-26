class FriendController < ApplicationController

	def my_friends
		@friendships = current_user.following_users
		@followers = current_user.user_followers
		
	end

	def search_friend
		@users =User.search(params[:search_param ])

		if @users
			# puts @users[0].name
			# puts @users[0].email
			@users = current_user.except_current_user(@users);
			
			render partial: "friend/lookup"

		else
			render status: not_found ,nothing: true
		end	

		
	end

	def addFriend
		@friend = User.find(params[:friend])
			if current_user
			    if current_user.id == @friend.id
			      redirect_to my_friends_path, flash[:error] = "You cannot follow yourself."
			    else
			      current_user.follow(@friend)
			      redirect_to myfriends_path
			    end
		  else
		    	flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
		  end
		
	end  

	def unFriend
			@user = User.find(params[:id])

		  if current_user
		    current_user.stop_following(@user)
			redirect_to myfriends_path
		  else
		    flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.monniker}.".html_safe
		  end
		
	end
end
