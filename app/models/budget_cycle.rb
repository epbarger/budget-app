class BudgetCycle < ApplicationRecord
  has_paper_trail

  belongs_to :budget, optional: true
  has_many :balance_events

  delegate :replenish_period, to: :budget
  delegate :name, to: :budget

  # budget_id
  # start_date
  # end_date
  # period_balance

  def current_balance
    unlocked_balance - amount_spent
  end

  def amount_spent
    balance_events.map(&:amount).compact.sum
  end

  def unlocked_balance
    ( (((day_in_cycle.to_f / replenish_period).ceil).to_f / number_of_periods_in_cycle) * period_balance ).round
  end

  def day_in_cycle # starts at day 1
    ((Time.zone.now.beginning_of_day - start_date) / 1.day.seconds + 1).to_i
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
end
