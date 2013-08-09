class SessionsController < ApplicationController
  def new
  end
  
  def create
    employee = Employee.authenticate(params[:employee], params[:password])
    if employee
      session[:employee_id] = employee.id
      redirect_to :controller => "home"
    else
      # неправильное имя или пароль
      render "new"
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to '/login'
  end
end
