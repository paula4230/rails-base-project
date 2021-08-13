class Transaction < ApplicationRecord
    belongs_to :user

    validates :stock_symbol, presence: true

end
