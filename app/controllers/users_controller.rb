class UsersController < ApplicationController
  before_action :zero_users_or_authenticated
  before_action :set_user, only: [:destroy, :edit, :update]
  after_action :verify_authorized

  attr_accessor :user, :users, :companies_array
  helper_method :user, :users, :companies_array

  def zero_users_or_authenticated
    unless User.count == 0 || current_user
      redirect_to root_path
      return false
    end
  end

  def index
    @users = User.all.order("active_status ASC, last_name ASC, first_name ASC")
    authorize users
  end

  def destroy
    user.destroy
    redirect_to users_path, notice: "User deleted"
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User updated successfully"
      redirect_to users_path
    else
      redirect_to users_path, error: "User update failed"
    end
  end

  def new
    @user = User.new
    authorize user
  end

  def create
    @user = User.new(user_params)
    authorize user

    respond_to do |format|
      if user.save
        format.html { redirect_to users_path, notice:
          "User created" }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def change_active_status
    user = User.find( params.require(:user_id) )
    authorize user
    if user.active?
      user.inactive!
      flash[:success] = "#{user.full_name} was archived."
    else
      user.active!
      flash[:success] = "#{user.full_name}'s account was made active again."
    end
    redirect_to users_path
  end

  # def add_user_to_company
  #   user = User.find( params.require(:user_id) )
  #   authorize user
  #   company = Company.find(
  #     params.require(:user).permit(:company_id)[:company_id] )
  #   user.profileable.add_company_to_self(company)
  #   if user.profileable.companies.include?(company)
  #     flash[:success] = "#{user.full_name} successfully added to " +
  #       company.title
  #     redirect_to users_path
  #   else
  #     redirect_to users_path, error: "Error adding #{user.full_name} to " +
  #       company.title
  #   end
  # end

  private
    def set_user
      @user = User.find(params.require(:id))
      authorize user
    end

    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :username,
      :profileable_type, :password, :password_confirmation)
    end
end
