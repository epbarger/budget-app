class CreateBudgetCycles < ActiveRecord::Migration[5.0]
  def change
    create_table :budget_cycles do |t|
      t.timestamps
      t.integer :budget_id
      t.index :budget_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer :period_balance
    end
  end
end
