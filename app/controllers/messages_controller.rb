class MessagesController < ApplicationController
  before_action :require_login
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_referer, only: [:destroy, :edit, :new, :show]

  attr_accessor :message, :sent_messages, :rcvd_messages
  helper_method :message, :sent_messages, :rcvd_messages

  def index
    @sent_messages = Message.where("sender_user_id = ?", current_user.id)
    @rcvd_messages = Message.where("recipient_user_id = ?", current_user.id)
  end

  def new
    @message = Message.new
  end

  def show
  end

  def edit
  end

  def create
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
end
