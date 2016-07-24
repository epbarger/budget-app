class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_paper_trail

  belongs_to :account

  before_validation :create_an_account

  attr_accessor :timezone

  def create_an_account
    self.account = Account.create(timezone: REVERSE_TZ_HASH[timezone], month_start: 1)
  end
end
