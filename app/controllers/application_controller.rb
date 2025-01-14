class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    

    protected

         def configure_permitted_parameters
              devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :first_name, :last_name, :bank_name, :bank_account_number, :account_balance)}
              devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :first_name, :last_name, :bank_name, :bank_account_number, :account_balance)}
         end


end
