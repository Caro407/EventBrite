class AddAttendanceStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :payment_status, :string, null: false, default: "pending"
  end
end
