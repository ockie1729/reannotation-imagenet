class AnnotationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @annotations = Annotation.includes(:image).all
  end
end
