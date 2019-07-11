class AnnotationsController < ApplicationController
  def index
    @annotations = Annotation.includes(:image).all
  end
end
