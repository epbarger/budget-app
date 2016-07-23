class AddOriginalAccountIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :original_account_id, :integer
  end
end
