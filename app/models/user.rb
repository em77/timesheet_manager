class User < ApplicationRecord
  belongs_to :profileable, polymorphic: true
  authenticates_with_sorcery!
end
