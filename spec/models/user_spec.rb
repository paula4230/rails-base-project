require 'rails_helper'

RSpec.describe User, :type => :model do
  
  it 'is database authenticable' do
    user = User.create(
      email: 'test@example.com', 
      password: 'password123',
      password_confirmation: 'password123',
      first_name:'test',
      last_name:'user',
      bank_name: 'Unreal bank',
      bank_account_number: 12345,
      account_balance: 5000
    )
    expect(user.valid_password?('password123')).to be_truthy
  end

  
  
  
end
