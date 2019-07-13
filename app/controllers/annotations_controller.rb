class AnnotationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @annotations = Annotation.includes(:image, :user).
                     all.order("updated_at DESC")
  end
end
