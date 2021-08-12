class HomeController < ApplicationController
before_action :authenticate_user!

    def index
      @users = User.all

    end

    def create
      @user = User.create(user_params)
      #@acccount_balance = 5000
      @user.save

    end

    private

    def user_params        
      params.require(:user).permit(:email, :password, :first_name, :last_name, :bank_name, :bank_account_number, :account_balance)
    end  


end