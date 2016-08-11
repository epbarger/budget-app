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
    if (budget_cycles.count == 0) || (!current_cycle && reoccuring)
      budget_cycles.create(start_date: get_current_start, end_date: get_current_end, period_balance: amount)

    elsif !current_cycle
      raise 'current cycle is missing'

    elsif current_cycle.start_date.day != account.month_start
      if !reoccuring || created_at > get_current_start
        current_cycle.update(start_date: get_current_start, end_date: get_current_end)
      else
        current_cycle.update(end_date: Time.now <= get_current_start ? get_current_start : get_current_end)
      end

    end
  end

  def get_current_start
    start = Time.now - 1.month
    while start.day != account.month_start
      start += 1.day
    end
    start.beginning_of_day
  end

  def get_current_end
    start = Time.now
    while start.day != account.month_start
      start += 1.day
    end
    (start - 1.day).end_of_day
  end

  def amount_in_dollars
    (amount / 100.0).to_i
  end

  def current_cycle
    time = Time.now
    budget_cycles.where("start_date <= ? AND end_date >= ?", time, time).order('created_at DESC').first
  end
end
