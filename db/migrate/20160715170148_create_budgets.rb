class CreateBudgets < ActiveRecord::Migration[5.0]
  def change
    create_table :budgets do |t|
      t.timestamps
      t.integer :account_id
      t.index :account_id
      t.integer :period
      t.boolean :monthly
      t.integer :replenish_period, default: 1
      t.boolean :reoccuring
    end
  end
end
