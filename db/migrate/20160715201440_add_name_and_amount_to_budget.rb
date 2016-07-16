class AddNameAndAmountToBudget < ActiveRecord::Migration[5.0]
  def change
    add_column :budgets, :amount, :integer
    add_column :budgets, :name, :string
    add_column :budgets, :hidden_at, :datetime
  end
end
