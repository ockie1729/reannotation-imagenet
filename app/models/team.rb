class Team < ApplicationRecord
  has_many :users
  has_many :image_classes
end
