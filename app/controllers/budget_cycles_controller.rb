class BudgetCyclesController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @budget = current_user.account.budgets.find(params[:budget_id])
    @budget_cycle = @budget.budget_cycles.where(id: params[:id]).first
    @new_balance_event = @budget_cycle.balance_events.build
  end
end
