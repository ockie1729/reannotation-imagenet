class ImagesController < ApplicationController
  # before_action :authenticate_user!

  def new
    image = Image.includes(:annotations).where(annotations: {id: nil}).first
    redirect_to action: "show", id: image.id
  end

  def show
    @image = Image.find(params[:id])
  end

  def update
    ann = Annotation.new(image_id: params[:image_id], label: params[:label],
			 user_id: current_user.id)
    ann.save! 
    redirect_to action: "new"
  end

  def images_tile
    @images = Image.all
  end

  def save_images_tile
    p params["_json"]
    render json: [true, {"status": "ok"}]
  end
end
