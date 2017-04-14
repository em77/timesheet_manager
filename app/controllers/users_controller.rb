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
    if params[:show_inactive]
      @users = User.where(active_status: :inactive)
        .order("last_name ASC, first_name ASC")
        .includes(:received_messages, :sent_messages)
        .paginate(page: params[:page])
    else
      @users = User.where(active_status: :active)
        .order("last_name ASC, first_name ASC")
        .includes(:received_messages, :sent_messages)
        .paginate(page: params[:page])
    end
    preload_profileable
    authorize users
  end

  def destroy
    user.destroy
    redirect_to users_path, notice: "#{user.full_name} was deleted"
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "#{user.full_name} updated successfully"
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
          "#{user.full_name} was created" }
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
      Job.archive_employee_jobs(user.profileable_id) unless user.is_an_admin?
      flash[:success] = "#{user.full_name} was archived"
    else
      user.active!
      flash[:success] = "#{user.full_name}'s account was made active again"
    end
    redirect_to users_path
  end

  def preload_profileable
    ActiveRecord::Associations::Preloader.new.preload(
      @users.select { |u| u.profileable_type == "EmployeeProfile" },
      { profileable: :jobs })
    ActiveRecord::Associations::Preloader.new.preload(
      @users.select { |u| u.profileable_type == "AdminProfile" },
      { profileable: :companies })
  end

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
