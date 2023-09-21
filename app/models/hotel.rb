class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :bookings, through: :rooms, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
end
