class AddUseridToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_reference :transactions, :user, null: false, foreign_key: true
  end
end
