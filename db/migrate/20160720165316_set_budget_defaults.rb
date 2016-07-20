class SetBudgetDefaults < ActiveRecord::Migration[5.0]
  def change
    change_column :budgets, :monthly, :boolean, default: true
    change_column :budgets, :reoccuring, :boolean, default: true
  end
end
