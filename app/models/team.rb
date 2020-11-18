class Team < ApplicationRecord
  has_many :users
  has_many :team_users
  has_many :image_classes
  has_many :image_clusters
end
