class CompaniesController < ApplicationController
  before_action :require_login
  before_action :set_company, only: [:edit, :update, :destroy, :show]
  before_action :set_referer, only: [:destroy, :edit, :new]
  before_action :set_admin_array, only: [:new, :edit]
  after_action :verify_authorized

  attr_accessor :company, :companies, :admin_array
  helper_method :company, :companies, :admin_array

  def index
    if params[:show_inactive]
      @companies = Company.where(active_status: :inactive)
        .order("title ASC")
        .includes(:employee_profiles)
    else
      @companies = Company.where(active_status: :active)
        .order("title ASC")
        .includes(:employee_profiles)
    end
    authorize companies
  end

  def new
    @company = Company.new
    authorize company
  end

  def show
  end

  def edit
  end

  def create
    @company = Company.new(company_params)
    authorize company

    if @company.valid?
      @company.save
      redirect_to(session.delete(:return_to) || companies_path,
        notice: "Company created successfully")
    else
      flash[:error] = @company.errors.full_messages.to_sentence
      redirect_to(session.delete(:return_to) || companies_path)
    end
  end

  def update
    if @company.update(company_params)
      flash[:success] = "Company updated successfully"
      redirect_to companies_path
    else
      redirect_to companies_path, error: "Company update failed"
    end
  end

  def destroy
    company.destroy
    redirect_to companies_path, notice: "Company deleted"
  end

  def change_active_status
    company = Company.find( params.require(:company_id) )
    authorize company
    if company.active?
      company.inactive!
      Job.archive_company_jobs(company.id)
      flash[:success] = "#{company.title} was archived."
    else
      company.active!
      flash[:success] = "#{company.title} was made active again."
    end
    redirect_to companies_path
  end

  private
    def set_company
      @company = Company.find(params.require(:id))
      authorize company
    end

    def set_admin_array
      @admin_array = AdminProfile.all.includes(:user).collect do |a|
        [a.user.full_name, a.id]
      end
    end

    def company_params
      params.require(:company).permit(:admin_profile_id, :title)
    end
end
