class Message < ApplicationRecord
  belongs_to :sender, class_name: "User", optional: true
  belongs_to :recipient, class_name: "User", optional: true
  enum read_status: [:unread, :read]
  after_initialize :set_default_read_status, if: :new_record?

  def set_default_read_status
    self.read_status ||= :unread
  end
end
