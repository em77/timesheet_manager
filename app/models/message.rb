class Message < ApplicationRecord
  belongs_to :admin_profile
  belongs_to :employee_profile
  enum read_status: [:unread, :read]
  after_initialize :set_default_read_status, if: :new_record?

  def user
    User
  end

  def set_default_read_status
    self.read_status ||= :unread
  end
end
