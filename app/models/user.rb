class User < ApplicationRecord
  has_many :hosted_events, class_name: "Event", source: :host

  has_many :attendances
  has_many :events, through: :attendances

  after_create :send_welcome_email, if: -> { Rails.env.production? }

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
