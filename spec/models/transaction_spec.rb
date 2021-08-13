require 'rails_helper'

RSpec.describe Transaction, type: :model do
  current_user = User.find_or_create_by(email: 'test@example.com', password: 'password', password_confirmation: 'password', first_name:'test', last_name:'user', bank_name:'Unreal', bank_account_number:12345, account_balance:5000)
 # current_user = User.where(id: 16)

  it 'should not save without symbol' do
    transaction = Transaction.new(
      stock_symbol: '',
      stock_name: 'any',
      current_price: 1000,
      count_shares:10,
      total_price:1000,
      user_id: current_user.id
    )
    expect(transaction).to_not be_valid
  end

  it 'has a symbol' do
    transaction = Transaction.new(
      stock_symbol: 'has symbol',
      stock_name: 'any',
      current_price: 1000,
      count_shares:10,
      total_price:1000,
      user_id: current_user.id
    )
    expect(transaction).to be_valid
  end

  it 'has at least 1 sold/bought share' do
    transaction = Transaction.create(
      stock_symbol: 'has symbol',
      stock_name: 'any',
      current_price: 1000,
      count_shares: 0,
      total_price:1000,
      user_id: current_user.id
    )
    expect(transaction).to_not be_valid

    # post.title = '12'
    # expect(post).to be_valid
  end


end
