class EmployeesController < ApplicationController
  before_action :authenticate_user!

  def index
    @employees = if params[:page].present?
                   EmployeeService.get_all(params[:page])
                 else
                   EmployeeService.get_all
                 end
  end

  def edit
    @employee = EmployeeService.get_one(params[:id])
  end

  def show
    @employee = EmployeeService.get_one(params[:id])
  end

  def create
    employee_params = {
      name: params[:name],
      position: params[:position],
      date_of_birth: params[:date_of_birth],
      salary: params[:salary]
    }
    @employee = EmployeeService.create(employee_params)
    redirect_to employee_path(@employee.dig('id'))
  end

  def update
    employee_params = {
      name: params[:name],
      position: params[:position],
      date_of_birth: params[:date_of_birth],
      salary: params[:salary]
    }
    @employee = EmployeeService.update(params[:id], employee_params)
    redirect_to edit_employee_path(@employee.dig('id'))
  end
end
