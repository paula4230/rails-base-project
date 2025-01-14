class PortfoliosController < ApplicationController
    before_action :is_current_user, only: %i[ sell_stock ]
    before_action :portfolio_operations
    before_action :request_api

    def index   
        @stock_symbol = @shares_ave.keys
        @sum = @shares_sum.values
        @ave = @shares_ave.values
        @stock_name = @total_price.keys
    end

    def calculate_sell_price
        @stock_name = @total_price.keys
        @stock_symbol = @shares_ave.keys
        @sum = @shares_sum.values
        @ave = @shares_ave.values
        
        @company = @client.company(params[:company])
        @quote = @client.quote(params[:company])

        @company_symbol = @company.symbol
        @company_name = @company.company_name
        @current_market_price = @quote.latest_price

        @count_shares = params[:count_shares] 
        @result = @count_shares.to_i * @current_market_price.to_f

        #compute profit per sold share
        # @transactions = current_user.transactions
        # @profit = (@count_shares * @current_market_price.to_i) - (@count_shares))

        render :index  
    end


    def sell_stock
        @transactions = current_user.transactions

        if @transactions.where(stock_symbol: transaction_params[:stock_symbol]).count > 0
            @transaction = current_user.transactions.create(transaction_params)
            @user = User.where(id: current_user.id)
            new_balance = current_user.account_balance + transaction_params[:total_price].to_f

            if @transaction.save && @user.update(account_balance: new_balance) 
                redirect_to transactions_path
            else
                render :new, status: :unprocessable_entity 
            end
        else
            redirect_to portfolios_path
        end

            # @final_shares = @shares_sum.where(:stock_symbol).sum(:count_shares) - @count_shares
    end

    private

    def request_api
        @client = IEX::Api::Client.new(
            publishable_token: Rails.application.credentials.iex[:publishable_token],
            secret_token: Rails.application.credentials.iex[:secret_token],
            endpoint: 'https://cloud.iexapis.com/v1'
        )       
    end
    
    def compute_total_price

        @total_price = @count_shares*@latest_price
    end

    def is_current_user
        @transaction = current_user.transactions.find_by(stock_symbol: params[:stock_symbol])
    end

    def portfolio_operations
        @shares_sum = current_user.transactions.group(:stock_symbol).sum(:count_shares)
        @shares_ave = current_user.transactions.group(:stock_symbol).average(:current_price)
        @total_price = current_user.transactions.group(:stock_name).sum(:total_price)
    end

    def transaction_params        
        params.require(:transaction).permit(:stock_name, :stock_symbol, :current_price, :count_shares, :total_price, :user_id, :latest_price)
    end  



end
