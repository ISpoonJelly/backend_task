class Bug < ApplicationRecord
  belongs_to :state, :dependent => :delete
  enum status: [:fresh, :in_progress, :closed]
  enum priority: [:minor, :major, :critical]
  validates :appToken, :number, :status, :priority, :comment, :state_id, :presence => true
  validates :number, uniqueness: { scope: [:appToken] }
end
