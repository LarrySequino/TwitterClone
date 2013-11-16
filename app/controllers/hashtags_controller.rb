class HashtagsController < ApplicationController
    def show
        @tag = Hashtag.find(params[:id])
        @tags = Hash.new
        hashtags = Hashtag.all.all? { |tag|  @tags[tag.name] = tag.id}
    end
end
