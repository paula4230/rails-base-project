class StocksController < ApplicationController
    before_action :request_api
    # before_action :calculate_total_price

    def index
        require 'iex-ruby-client'
    end

    def search
        @company = @client.company(params[:company])
        @quote = @client.quote(params[:company])
        @key_stats = @client.key_stats(params[:company]) 
        
        @company_symbol = @company.symbol
        @company_name = @company.company_name

        @current_price = @quote.latest_price
        @change_percent_s = @quote.change_percent_s   
        @outstanding_shares = @key_stats.shares_outstanding
        
        if @company
            render :index
        else
            flash[:alert] = 'Company not found'
            render :index
        end       
    end

    # def count_shares
    #     @count_shares
    # end

    def calculate_total_price
        @company = @client.company(params[:company])
        @quote = @client.quote(params[:company])
        @key_stats = @client.key_stats(params[:company]) 

        @company_symbol = @company.symbol
        @company_name = @company.company_name
        @current_price = @quote.latest_price

        @change_percent_s = @quote.change_percent_s   
        @outstanding_shares = @key_stats.shares_outstanding

        @count_shares = params[:count_shares]
        @result = @count_shares.to_i * @current_price.to_f

        @confirmation_message = "You are about to purchase #{@count_shares} share/s for $#{@result}."
        render :index
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

    def user_params        
        params.require(:user).permit(:email, :password, :first_name, :last_name, :bank_name, :bank_account_number, :account_balance)
      end 

end
