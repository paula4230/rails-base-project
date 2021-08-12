class AddAdditionalinfosToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :bank_name, :string
    add_column :users, :bank_account_number, :string
    add_column :users, :account_balance, :float
  end
end
