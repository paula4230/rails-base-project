class AddLatestpriceToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :latest_price, :float
  end
end
