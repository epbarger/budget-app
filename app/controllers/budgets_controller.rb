class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all
  end

  def show # list of all budget cyces
    redirect_to action: :index
  end

  def new
    @budget = Budget.new
  end

  def create
    @budget = Budget.create( budget_params.merge({ amount: (budget_params[:amount].to_f * 100.0).to_i }) )
    @budget.create_initial_cycle
    redirect_to action: :index
  end

  def edit
    @budget = Budget.find(params[:id])
  end

  def update
    @budget = Budget.find(params[:id]).update( budget_params.merge({ amount: (budget_params[:amount].to_f * 100.0).to_i }) )
    redirect_to action: :index
  end

  def destroy
  end

  private

  def budget_params
    params.require(:budget).permit(:period, :monthly, :replenish_period, :reoccuring, :name, :amount)
  end
end
