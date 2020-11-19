class ImageCluster < ApplicationRecord
  belongs_to :image_class
  belongs_to :team, optional: true
  has_many :images
end
