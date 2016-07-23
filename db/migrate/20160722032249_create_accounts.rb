class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.timestamps
      t.string :timezone
      t.integer :month_start
    end
  end
end
