module Admin
  class AttendancesController < AdminController
    def index
      @attendances = Attendance.order(created_at: :desc)
    end
  end
end
