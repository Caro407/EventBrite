class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances

  belongs_to :host, class_name: "User"

  validates :start_date, presence: true
  validate :is_passed?

  validates :duration,
    presence: true,
    numericality: { greater_than: 0 }
  validate :is_multiple_of_5?

  validates :title,
    presence: true,
    length: { in: 5..140 }

  validates :description,
    presence: true,
    length: { in: 20..1000 }

  validates :price,
    presence: true,
    numericality: { greater_than: 0, less_than_or_equal_to: 1000 }

  validates :location,
    presence: true

  def is_passed?
    errors.add(:base, "Start date can't be set in the past.") if start_date < DateTime.now
  end

  def is_multiple_of_5?
    errors.add(:base, "Duration has to be a multiple of 5.") unless duration % 5 == 0
  end
end
