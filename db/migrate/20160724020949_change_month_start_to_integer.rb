class ChangeMonthStartToInteger < ActiveRecord::Migration[5.0]
  def change
    remove_column :accounts, :month_start
    add_column :accounts, :month_start, :integer, default: 1
  end
end
