class ImageClass < ApplicationRecord
  has_many :images
  has_many :image_clusters
end
