class User < ApplicationRecord
  has_paper_trail

  has_one :account

  # timezone
  # start_week_on
end
