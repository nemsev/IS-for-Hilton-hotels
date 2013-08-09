class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def require_login
    if session[:employee_id]
      @current_employee = Employee.find(session[:employee_id])
    else
      redirect_to '/login'
    end
  end  
end
