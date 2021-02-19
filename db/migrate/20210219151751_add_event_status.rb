class AddEventStatus < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :status, :string, null: false, default: "to validate"
  end
end
