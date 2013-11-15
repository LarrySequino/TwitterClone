class TweetsController < ApplicationController
    before_filter :check_login

    def index
        @tweets = current_user.followed_users.map(&:tweets).flatten
    end

    def create
    	@tweet = Tweet.new(tweet_params)
    	@tweet.user_id = session[:user_id]
    	if @tweet.save

                        tokens = @tweet.body.strip.split
                        
                        tokens.each do |token|
                            if token.include? ?#
                                tag = Hashtag.new
                                tag.name = token

                                if tag.save
                                    @tweet.hashtags << tag
                                end
                            end
                        end

    		redirect_to user_path(current_user)
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

    def favorite
        @star = Star.new
        @star.tweet = Tweet.find(params[:id])
        @star.user = current_user

        if @star.save
            redirect_to tweet_path(params[:id])
        else
            redirect_to user_path(current_user)
        end
    end

    def retweet
        @retweet = Tweet.new
        @tweet = Tweet.find(params[:id])

        @retweet.body = "RT: " + @tweet.body
        @retweet.user = current_user

        if @retweet.save
            redirect_to user_path(current_user)
        else
            redirect_to user_path(@tweet.user)
        end
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
