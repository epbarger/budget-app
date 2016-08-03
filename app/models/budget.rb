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

  def check_and_create_cycle
    if (budget_cycles.count == 0) 
      budget_cycles.create(start_date: get_current_start, end_date: get_current_end, period_balance: amount)
      # current_cycle.balance_events.create(amount: current_cycle.unlocked_balance, note: 'New Budget Filler Transaction') # TODO, make it hidden

    elsif !current_cycle && reoccuring
      budget_cycles.create(start_date: get_current_start, end_date: get_current_end, period_balance: amount)

    elsif !current_cycle
      raise 'current cycle is missing'

    elsif current_cycle.start_date.day != account.month_start
      if !reoccuring # || created_at > get_current_start # re-think how the fuck this is supposed to work
        current_cycle.update(start_date: get_current_start, end_date: get_current_end)
      else
        current_cycle.update(end_date: Time.zone.now <= get_current_start ? get_current_start : get_current_end)
      end

    end
  end

  def get_current_start
    start = Time.zone.now - 1.month + 1.day
    while start.day != account.month_start
      start += 1.day
    end
    start.beginning_of_day
  end

  def get_current_end
    start = Time.zone.now + 1.day
    while start.day != account.month_start
      start += 1.day
    end
    (start - 1.day).end_of_day
  end

  def amount_in_dollars
    (amount / 100.0).to_i
  end

  def current_cycle
    time = Time.zone.now
    budget_cycles.where("start_date <= ? AND end_date >= ?", time, time).order('created_at DESC').first
  end

  def update_current_cycle_balance
    current_cycle.update(period_balance: amount)
  end
end
