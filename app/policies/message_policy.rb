class MessagePolicy < ApplicationPolicy
  attr_reader :current_user, :message

  def initialize(current_user, model)
    @current_user = current_user
    @message = model
  end

  def new?
    create?
  end

  def create?
    true
  end

  def show?
    [message.sender, message.recipient].include?(current_user)
  end

  def destroy?
    [message.sender, message.recipient].include?(current_user)
      && current_user.is_an_admin?
  end

  def edit?
    update?
  end

  def update?
    (current_user == message.sender) && current_user.is_an_admin?
  end
end
