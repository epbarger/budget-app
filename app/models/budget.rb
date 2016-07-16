class Budget < ApplicationRecord
  has_paper_trail

  belongs_to :account, optional: true
  has_many :budget_cycles

  # account_id
  # period (days)
  # monthly (true/false)
  # replenish_period (days)
  # reoccuring
  # name
  # amount

  def create_initial_cycle
    if monthly
      budget_cycles.create(start_date: Time.zone.now.beginning_of_month, end_date: Time.zone.now.end_of_month, period_balance: amount)
    else
      budget_cycles.create(start_date: Time.zone.now.beginning_of_day, end_date: Time.zone.now.beginning_of_day - 1.minute + period.days, period_balance: amount)
    end
  end

  def amount_in_dollars
    (amount / 100.0).to_i
  end

  def check_and_create_next_cycle
    if reoccuring
      previous_cycle = budget_cycles.order("created_at DESC").first
      unless previous_cycle.active
        if monthly
          budget_cycles.create(start_date: Time.zone.now.beginning_of_month, end_date: Time.zone.now.end_of_month, period_balance: amount)
        else
          if Time.zone.now < (previous_cycle.end_date + period.days) # within the "next" cycles period
            start_date = (previous_cycle.end_date + 5.minutes).beginning_of_day
            budget_cycles.create(start_date: start_date, end_date: start_date - 1.minute + period.days, period_balance: amount)
          else # otherwise just reset it and start it now
            budget_cycles.create(start_date: Time.zone.now.beginning_of_day, end_date: Time.zone.now.beginning_of_day - 1.minute + period.days, period_balance: amount)
          end
        end
      end
    end
  end
end
