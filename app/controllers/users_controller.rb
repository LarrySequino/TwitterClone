class UsersController < ApplicationController


            def index
                @users = User.all
            end
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
                        @tweets = @user.tweets + @user.mention_tweets
                        @tweets.sort_by {|twt| twt.created_at}
		@tweet = Tweet.new
                        @tags = Hash.new
                        @tagged_users = Hash.new
                        hashtags = Hashtag.all.all? { |tag|  @tags[tag.name] = tag.id}
	end

            def show_name
                @user = User.find_by_username(params[:username])
                if @user != nil
                    redirect_to "/users/#{@user.id}"
                else
                    redirect_to root_path
                end
            end


	def follow
		@user = User.find(params[:id])
		if @user 
			@relationship = Relationship.new
			@relationship.follower_id = current_user.id
			@relationship.followed_user_id = @user.id
			if @relationship.save
				redirect_to user_path(current_user)
			else
				redirect_to root_path
			end
		else
			redirect_to root_path
		end	
	end

            def unfollow
                @relationship = Relationship.where(:followed_user_id => params[:id], :follower_id => session[:user_id])
                if @relationship.count > 0
                    Relationship.destroy(@relationship[0].id)
                    redirect_to user_path(current_user)
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