class AccountsController < ApplicationController
  def new 
    @account = Account.new
    @account.build_person
    @no_header = true
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      RegistrationMailer.welcome_email(@account.person).deliver
      redirect_to root_path, notice: 'Account was successfully created.'
    else
      render action: 'new'
    end
  end
  
  private
    def account_params
      params.require(:account).permit(:email, :password, :password_confirmation, person_attributes: [ :first_name, :last_name, ]) 
    end
end
