class User < ApplicationRecord
  has_many :hosted_events, class_name: "Event"

  has_many :attendances
  has_many :events, through: :attendances
end
