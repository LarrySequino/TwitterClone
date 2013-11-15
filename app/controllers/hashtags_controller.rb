class HashtagsController < ApplicationController
    def show
        @tag = Hashtag.find(params[:id])
    end
end
