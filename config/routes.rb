Rails.application.routes.draw do
  devise_for :users
  root "images#images_tile"

  get "images/new", to: "images#new"
  get "images/tiles", to: "images#images_tile"
  get "images/:id", to: "images#show"

  post "images/annotate", to: "images#update"
  post "images/tiles", to: "images#save_images_tile"

  get "annotations", to: "annotations#index"
end
