class User < ApplicationRecord
  has_secure_password

  # Enums
  enum :role, { free: 0, premium: 1, creator: 2, admin: 3 }
end
