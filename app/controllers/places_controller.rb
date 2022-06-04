class PlacesController < ApplicationController

  def index
    if @current_user
      @places = Place.where({"user_id" => @current_user["id"]})
    end
  end

  def show
    @place = Place.find_by({ "id" => params["id"] })
    @posts = Post.where({ "place_id" => @place["id"] })
  end

  def new
    if @current_user
      @place = Place.new
    else
      flash["notice"] = "Login first."
      redirect_to "/"
    end
  end

  def create
    if @current_user
      @place = Place.new
      @place["name"] = params["place"]["name"]
      @place["user_id"] = @current_user["id"]
      @place.save
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/"
  end

end
