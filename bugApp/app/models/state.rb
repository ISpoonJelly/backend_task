class State < ApplicationRecord
  has_one :bug
  validates :device, :os, :memory, :storage, :presence => true
end
