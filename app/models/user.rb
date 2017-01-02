class User < ApplicationRecord
  belongs_to :profileable, polymorphic: true
  after_save :set_full_name
  authenticates_with_sorcery!

  def set_full_name
    self.update_column(:full_name, "#{self.first_name} #{self.last_name}")
  end
end
