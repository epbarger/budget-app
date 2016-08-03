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
      budget_cycles.create(start_date: Time.zone.now.beginning_of_month + day_offset, end_date: Time.zone.now.end_of_month + day_offset, period_balance: amount)
    elsif !current_cycle
      raise 'current cycle is missing'
    elsif current_cycle.start_date.day != account.month_start
      if !reoccuring || budget_cycles.count == 1
        current_cycle.update(start_date: Time.zone.now.beginning_of_month + day_offset, end_date: Time.zone.now.end_of_month + day_offset)
      else
        current_cycle.update(end_date: Time.zone.now.end_of_month + day_offset)
      end
    end
  end

  def amount_in_dollars
    (amount / 100.0).to_i
  end

  def current_cycle
    budget_cycles.where("start_date <= ? AND end_date >= ?", Time.zone.now, Time.zone.now).order('created_at DESC').first
  end

  def day_offset
    (account.month_start - 1).days
  end
end
