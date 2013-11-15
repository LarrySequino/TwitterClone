class TweetsController < ApplicationController
before_filter :check_login

def index
    @tweets = Tweet.all
end

def create
	@tweet = Tweet.new(tweet_params)
	@tweet.user_id = session[:user_id]
	if @tweet.save
		redirect_to tweet_path(@tweet)
	else
		render :new
	end
end

def show
	@tweet = Tweet.find(params[:id])
end

def new
	@tweet = Tweet.new
end

    private
def tweet_params
	params.require(:tweet).permit(:body)
end

	def check_login
		if session[:user_id] == nil
			redirect_to login_path
		end
	end

end
