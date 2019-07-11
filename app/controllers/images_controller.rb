class ImagesController < ApplicationController
  def new
    image = Image.includes(:annotations).where(annotations: {id: nil}).first
    redirect_to action: "show", id: image.id
  end

  def show
    @image = Image.find(params[:id])
  end

  def update
    ann = Annotation.new(image_id: params[:image_id], label: params[:label])
    ann.save! 
    redirect_to action: "new"
  end 
end
