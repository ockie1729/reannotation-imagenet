class ImageClass < ApplicationRecord
  belongs_to :team
  has_many :images
end
