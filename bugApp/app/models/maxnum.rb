class Maxnum < ApplicationRecord
  validates :appToken, :max, :presence => true
end
