class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_paper_trail

  belongs_to :account

  before_validation :create_an_account

  def create_an_account
    self.account = Account.create
  end
end
