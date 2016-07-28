class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_and_create_budget_cycles
  before_action :set_paper_trail_whodunnit
  around_action :set_time_zone

  protected

  def set_time_zone
    Time.use_zone(current_user.try(:account).try(:timezone) || 'UTC') { yield }
  end

  def check_and_create_budget_cycles
    set_time_zone do 
      current_user.account.budgets.each(&:check_and_create_cycle)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:timezone])
  end
end
