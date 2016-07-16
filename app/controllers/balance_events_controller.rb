class BalanceEventsController < ApplicationController
  def create
    budget = Budget.find(params[:budget_id])
    budget_cycle = budget.budget_cycles.find(params[:budget_cycle_id])
    budget_cycle.balance_events.create( balance_event_params.merge({ amount: (balance_event_params[:amount].to_f * 100.0).to_i }) )
    redirect_to budget_budget_cycle_path(budget, budget_cycle)
  end

  private

  def balance_event_params
    params.require(:balance_event).permit(:amount, :note)
  end
end
