module ApplicationHelper
  def cents_to_currency(cents)
    number_to_currency(cents / 100.0)
  end
end
