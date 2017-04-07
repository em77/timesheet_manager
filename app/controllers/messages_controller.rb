class MessagesController < ApplicationController
  before_action :require_login
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new, :show]
  before_action :set_companies_array, only: [:new, :edit]
  after_action :verify_authorized, except: [:autocomplete_user_full_name]

  autocomplete :user, :full_name, full: true

  attr_accessor :message, :messages, :companies_array
  helper_method :message, :messages, :companies_array

  def index
    if params[:show_sent]
      @messages = current_user.sent_messages
        .order("updated_at asc")
        .paginate(page: params[:page], per_page: 10)
    else
      @messages = current_user.received_messages
        .order("updated_at asc")
        .paginate(page: params[:page], per_page: 10)
    end
    authorize messages
  end

  def new
    @message = Message.new
    authorize message
  end

  def show
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    authorize message
    @message.sender = current_user

    if @message.valid?
      @message.save
      redirect_to(session.delete(:return_to) || messages_path,
        notice: "Message sent successfully")
    else
      flash[:error] = @message.errors.full_messages.to_sentence
      redirect_to(session.delete(:return_to) || messages_path)
    end
  end

  def update
  end

  def destroy
  end

  def get_autocomplete_items(parameters)
    authorize Message, :is_an_admin?
    items = active_record_get_autocomplete_items(parameters)
    items.where(active_status: :active).where(
      profileable_type: "EmployeeProfile")
  end

  private
    def set_message
      @message = Message.find(params.require(:id))
      authorize message
    end

    def set_companies_array
      @companies_array = current_user.profileable.companies.all.collect {|c|
      [c.title, AdminProfile.find(c.admin_profile_id).user.id]
      } unless current_user.is_an_admin?
    end

    def message_params
      params.require(:message).permit(:recipient_id, :subject, :content)
    end
end
