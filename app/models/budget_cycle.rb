class BudgetCycle < ApplicationRecord
  has_paper_trail

  belongs_to :budget, optional: true
  has_many :balance_events

  delegate :replenish_period, to: :budget
  delegate :name, to: :budget

  validate :does_not_overlap_with_existing_cycle

  # budget_id
  # start_date
  # end_date
  # period_balance

  def balance_vs_unlocked
    unlocked_balance - amount_spent
  end

  def current_balance
    adjusted_period_balance - amount_spent
  end

  def amount_spent
    balance_events.map(&:amount).compact.sum
  end

  def unlocked_balance
    # ( (((day_in_cycle.to_f / replenish_period).ceil).to_f / number_of_periods_in_cycle) * adjusted_period_balance ).round
    ([(day_in_cycle.to_f / number_of_days_in_cycle), 1.0].min * adjusted_period_balance).round
  end

  def day_in_cycle # starts at day 1
    # ((Time.zone.now.beginning_of_day - start_date) / 1.day.seconds + 1).to_i
    number_of_days_in_cycle - ((end_date - Time.zone.now) / (60*60*24)).floor
  end

  def number_of_days_in_cycle
    ((end_date - start_date) / 1.day.seconds).round
  end

  def number_of_periods_in_cycle
    (number_of_days_in_cycle.to_f / replenish_period).floor
  end

  def active
    time = Time.zone.now
    time < end_date && time > start_date
  end

  def short_cycle?
    days_in_month = Time.days_in_month(start_date.month)
    return true if number_of_days_in_cycle < days_in_month
    false
  end

  def long_cycle?
    days_in_month = Time.days_in_month(start_date.month)
    return true if number_of_days_in_cycle > days_in_month
    false
  end

  def adjusted_period_balance
    days_in_month = Time.days_in_month(start_date.month)
    period_balance * number_of_days_in_cycle / days_in_month
  end

  private

  def does_not_overlap_with_existing_cycle
    if budget.budget_cycles.where("id != ? and start_date >= ? and end_date <= ?", id, start_date, end_date).count > 0
      errors.add(:base, 'there is already a budget cycle in this time period')
    end
  end
end
