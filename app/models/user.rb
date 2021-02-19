class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :hosted_events, class_name: "Event", source: :host

  has_many :attendances
  has_many :events, through: :attendances

  has_one_attached :avatar

  after_create :send_welcome_email, if: -> { Rails.env.production? }

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

  def full_name
    full_name = self.first_name + " " + self.last_name
    return full_name
  end
end
