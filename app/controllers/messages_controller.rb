class MessagesController < ApplicationController
  before_action :require_login
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new, :show]
  before_action :set_companies_array, only: [:new, :edit]
  after_action :verify_authorized, except: [:autocomplete_user_full_name]

  autocomplete :user, :full_name, full: true

  attr_accessor :message, :sent_messages, :rcvd_messages, :companies_array
  helper_method :message, :sent_messages, :rcvd_messages, :companies_array

  def index
    @sent_messages = Message.where("sender_user_id = ?", current_user.id).order(
      "updated_at asc")
    @rcvd_messages = Message.where("recipient_user_id = ?", current_user.id)
      .order("updated_at asc")
    authorize sent_messages
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
    @message.sender_user_id = current_user.id

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
      params.require(:message).permit(:recipient_user_id, :subject, :content)
    end
end
