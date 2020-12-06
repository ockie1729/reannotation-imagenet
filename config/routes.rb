Rails.application.routes.draw do
  root "images#images_tile"

  devise_for :users

  get 'competitions/running'
  get 'competitions/next'

  get 'entrance_page/index'

  get 'static_pages/finished'

  get "images/new", to: "images#new"
  get "images/tiles", to: "images#images_tile"
  get "images/:id", to: "images#show"

  post "images/annotate", to: "images#update"
  post "images/tiles/decide", to: "images#commit_images_tile"
  post "images/tiles/image_clusters/:image_cluster_id", to: "images#save_images_tile"

  get "annotations", to: "annotations#index"

  get "leaderboard", to: "leader_board#index"
end
