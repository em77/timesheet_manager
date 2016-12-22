class MessagePolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @message = model
  end

  def show?
    [@message.sender_user_id, @message.recipient_user_id].include?(
      @current_user.id)
  end

  def destroy?
    [@message.sender_user_id, @message.recipient.user_id].include?(
      @current_user.id) && (@current_user.profileable_type == "AdminProfile")
  end

  def edit?
    (@current_user.id == @message.sender_user_id) &&
      (@current_user.profileable_type == "AdminProfile")
  end

  def update?
    (@current_user.id == @message.sender_user_id) &&
      (@current_user.profileable_type == "AdminProfile")
  end
end
