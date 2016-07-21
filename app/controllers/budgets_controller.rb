class BudgetsController < ApplicationController
  def index
    @budgets = Budget.all.order("created_at")
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
    @budget = Budget.find(params[:id])
    @budget.update( budget_params.merge({ amount: (budget_params[:amount].to_f * 100.0).to_i }) )
    redirect_to budget_budget_cycle_path(@budget, @budget.current_cycle)
  end

  def destroy
    @budget = Budget.find(params[:id])
    @budget.destroy!
    redirect_to action: :index
  end

  private

  def budget_params
    params.require(:budget).permit(:period, :monthly, :replenish_period, :reoccuring, :name, :amount)
  end
end
