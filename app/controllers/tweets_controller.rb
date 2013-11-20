class TweetsController < ApplicationController
    before_filter :check_login

    def index
        @tweets = current_user.followed_users.map(&:tweets).flatten + current_user.tweets + current_user.mention_tweets
        @tweets.uniq!
        @tweets.sort_by! {|twt| twt.created_at}
        @tags = Hash.new
        hashtags = Hashtag.all.all? { |tag|  @tags[tag.name] = tag.id}

        @tweet = Tweet.new
        @users = User.all
    end

    def create
    	@tweet = Tweet.new(tweet_params)
    	@tweet.user_id = session[:user_id]
    	if @tweet.save

                        tokens = @tweet.body.strip.split
                        
                        tokens.each do |token|

                            if token[0] == '#' and token.length > 1
                                tag = Hashtag.find_by_name(token)
                                if  tag != nil
                                    @tweet.hashtags << tag
                                else
                                    tag = Hashtag.new
                                    tag.name = token

                                    if tag.save
                                        @tweet.hashtags << tag
                                    end
                                end

                            elsif token[0] == '@' and token.length > 1
                                user = User.find_by_username(token[1..-1])
                                mention = Mention.new
                                mention.user = user
                                mention.tweet = @tweet
                                mention.save
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
        @retweeted_tweet = Tweet.new
        @tweet = Tweet.find(params[:id])

        @retweeted_tweet.body = "RT: " + @tweet.body
        @retweeted_tweet.user = current_user

        if @retweeted_tweet.save

                @retweet = Retweet.new
                @retweet.tweet = @tweet
                @retweet.user = current_user

                if @retweet.save
                    redirect_to user_path(current_user)
                else
                    redirect_to root_path
                end

        else
            redirect_to user_path(@tweet.user)
        end
    end

    def hashtag_path(name)
        tag = Hashtag.find_by_name(name)

        @path = "/hashtags/#{tag.id}"
    end
    helper_method :hastag_path

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
