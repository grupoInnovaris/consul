class WebSection < ApplicationRecord
  include Cardable
  has_many :sections
  has_many :banners, through: :sections
end
