class User < ApplicationRecord
  belongs_to :profileable, polymorphic: true
  after_save :set_full_name
  before_save :set_profileable, if: :new_record?
  authenticates_with_sorcery!
  validates_confirmation_of :password,
    message: "- Passwords must match", if: :password
  validates_uniqueness_of :username
  validates :username, presence: true
  validates :email, presence: true, if: "profileable_type == 'AdminProfile'"
  enum active_status: [:active, :inactive]
  after_initialize :set_default_active_status, if: :new_record?

  def set_default_active_status
    self.active_status ||= :active
  end

  def is_an_admin?
    self.profileable_type == "AdminProfile"
  end

  # Tell Sorcery to deny authentication to inactive users
  def active_for_authentication?
    self.active?
  end

  def set_full_name
    self.update_column(:full_name, "#{self.first_name} #{self.last_name}")
  end

  def set_profileable
    return unless self.profileable_type
    profile = self.profileable_type.constantize.new
    profile.save
    self.profileable = profile
  end
end
