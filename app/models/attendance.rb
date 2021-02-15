class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :send_notif_email, if: -> { Rails.env.production? }

  def send_notif_email
    UserMailer.attendance_notif_email(self).deliver_now
  end
end
