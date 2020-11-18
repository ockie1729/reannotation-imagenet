class ImageCluster < ApplicationRecord
  belongs_to :image_class
  belongs_to :team
  has_many :images
end
