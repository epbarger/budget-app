class Account < ApplicationRecord
  has_paper_trail
  
  belongs_to :user
  has_many :budgets
end
