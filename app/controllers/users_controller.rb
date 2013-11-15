class UsersController < ApplicationController


	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to "/users/#{@user.id}"
		else
			render :new
		end
	end

	def show

		if session[:user_id] == nil
			redirect_to login_path
		end

		@user = User.find(params[:id])
		@tweet = Tweet.new
	end


	def follow
		@user = User.find(params[:id])
		if @user 
			@relationship = Relationship.new
			@relationship.follower = current_user 
			@relationship.followed_user = @user
			if @relationship.save
				redirect_to user_path(current_user)
			else
				redirect_to show_path(current_user)
			end
		else
			redirect_to root_path
		end	
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end

	def check_login
		if session[:user_id] == nil
			redirect_to login_path
		end
	end

end