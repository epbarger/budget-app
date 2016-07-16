class BalanceEvent < ApplicationRecord
  belongs_to :budget_cycle

  # budget_cycle_id
  # amount
  # note
end
