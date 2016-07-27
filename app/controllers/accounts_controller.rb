class AccountsController < ApplicationController
  def edit
    @user = current_user
    @account = @user.account
  end

  def update
    current_user.account.update(account_params)
    flash[:notice] = "Your account settings were updated successfully."
    redirect_to action: :edit
  end

  private

  def account_params
    params.require(:account).permit(:month_start, :timezone)
  end
end
