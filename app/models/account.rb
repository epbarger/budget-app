class Account < ApplicationRecord
  has_paper_trail
  
  has_many :users
  has_many :budgets

  #timezone
  #month_start
end
