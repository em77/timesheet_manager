class MessagesController < ApplicationController
  before_action :require_login
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new, :show]

  autocomplete :user, :full_name, full: true

  attr_accessor :message, :sent_messages, :rcvd_messages
  helper_method :message, :sent_messages, :rcvd_messages

  def index
    @sent_messages = Message.where("sender_user_id = ?", current_user.id).order(
      "updated_at asc")
    @rcvd_messages = Message.where("recipient_user_id = ?", current_user.id)
      .order("updated_at asc")
  end

  def new
    @message = Message.new
  end

  def show
  end

  def edit
  end

  def create
    @message = Message.new(message_params)
    @message.sender_user_id = current_user.id

    if @message.valid?
      @message.save
      redirect_to(session.delete(:return_to),
        notice: "Message sent successfully")
    else
      flash[:error] = @message.errors.full_messages.to_sentence
      redirect_to(session.delete(:return_to))
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

    def message_params
      params.require(:message).permit(:recipient_user_id, :subject, :content)
    end
end
