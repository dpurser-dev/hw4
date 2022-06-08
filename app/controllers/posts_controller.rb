class PostsController < ApplicationController

  def new
    if @current_user
      @post = Post.new
      @place = Place.find_by({ "id" => params["place_id"] })
      @post["place_id"] = @place["id"]
    else
      flash["notice"] = "Please login first"
      redirect_to "/"
    end
  end

  def create
    if @current_user
      @post = Post.new
      @post["title"] = params["post"]["title"]
      @post["description"] = params["post"]["description"]
      @post["posted_on"] = params["post"]["posted_on"]
      @post["place_id"] = params["post"]["place_id"]
      @post["user_id"] = @current_user["id"]
      @post.uploaded_image.attach(params["post"]["uploaded_image"])
      @post.save
      redirect_to "/places/#{@post["place_id"]}"
    else
      flash["notice"] = "Please login first"
      redirect_to "/"
    end
  end

end
