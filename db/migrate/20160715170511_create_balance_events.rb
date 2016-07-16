class CreateBalanceEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :balance_events do |t|
      t.timestamps
      t.integer :budget_cycle_id
      t.index :budget_cycle_id
      t.integer :amount
      t.string :note
    end
  end
end
