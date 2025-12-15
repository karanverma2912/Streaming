class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :username, :role, :bio, :email_verified, :otp_code, :otp_expires_at, :password_digest, :password_reset_sent_at, :password_reset_token, :phone_number, :subscription_id, :created_at, :updated_at
end
