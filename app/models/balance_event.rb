class BalanceEvent < ApplicationRecord
  belongs_to :budget_cycle

  validate :active_cycle, on: :create

  # budget_cycle_id
  # amount
  # note

  def destroy
    raise 'cant destroy if the cycle is inactive' unless budget_cycle.active
    super
  end

  private

  def active_cycle
    errors.add(:base, 'budget cycle is inactive') unless budget_cycle.active
  end
end
