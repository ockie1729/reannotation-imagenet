class ImageClass < ApplicationRecord
  belongs_to :team
  has_many :images
  has_many :image_clusters
end
