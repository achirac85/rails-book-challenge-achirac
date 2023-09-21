class Booking < ApplicationRecord
  attr_accessor :date_range
  belongs_to :user
  belongs_to :room
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
