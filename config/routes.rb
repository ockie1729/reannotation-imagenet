Rails.application.routes.draw do
  get "images/new", to: "images#new"
  get "images/:id", to: "images#show"
  post "images/annotate", to: "images#update"

  get "annotations", to: "annotations#index"
end
