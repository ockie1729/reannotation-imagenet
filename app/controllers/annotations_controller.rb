class AnnotationsController < ApplicationController
  include Common

  before_action :check_sign_in

  def index
    @annotations = Annotation.includes(:image, :user).
                     all.order("updated_at DESC")
  end
end
