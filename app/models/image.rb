class Image < ApplicationRecord
  belongs_to :image_class
  has_many :annotations
end
