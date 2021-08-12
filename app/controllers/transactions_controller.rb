class TransactionsController < ApplicationController
    before_action :set_transaction, only: %i[ show edit update destroy ]

    def index
        @transactions = current_user.transactions
    end

    def new
        @transaction = current_user.transactions.new
    end

    def show
    end

    def buy_stock
        @transaction = current_user.transactions.build(transaction_params)
        @user = User.where(id: current_user.id)

        new_balance = current_user.account_balance - transaction_params[:total_price].to_f
    
        if @transaction.save && @user.update(account_balance: new_balance) 
            redirect_to transactions_path
        else
            render :new, status: :unprocessable_entity 
        end

    end

    private
    
    def set_transaction
        @transaction = current_user.transactions.find(params[:id])
    end

    def transaction_params        
        params.require(:transaction).permit(:stock_name, :stock_symbol, :current_price, :count_shares, :total_price, :user_id)
    end                                                                                                

    def is_current_user
        @transaction = current_user.transactions.find_by(id: params[:user_id])
    end


    # def user_params        
    #     params.require(current_user).permit(:email, :password, :first_name, :last_name, :bank_name, :bank_account_number, :account_balance)
    # end 


end
