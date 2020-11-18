class Image < ApplicationRecord
  belongs_to :image_class
  belongs_to :image_cluster
  has_many :annotations
end
