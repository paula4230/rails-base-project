class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :transactions
  has_many :portfolios

  #validates :first_name, presence: true
  #validates :last_name, presence: true
  #validates :bank_name, presence: true
  #validates :bank_account_number, presence: true

  #attr_accessor :first_name, :last_name, :bank_name, :bank_account_number

end
