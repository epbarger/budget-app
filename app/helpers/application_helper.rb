module ApplicationHelper
  def cents_to_currency(cents)
    number_to_currency(cents / 100.0)
  end

  def balance_color(budget_cycle, bright=false)
    if budget_cycle.balance_vs_unlocked > 0.0
      bright ? 'positive-bright' : 'positive'
    elsif budget_cycle.current_balance > 0.0
      bright ? 'over-pace-bright' : 'over-pace'
    else
      bright ? 'negative-bright' : 'negative'
    end
  end 
end
