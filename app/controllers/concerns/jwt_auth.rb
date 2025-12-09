# app/controllers/concerns/jwt_auth.rb
module JwtAuth
  def self.encode(payload, exp: 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secret_key_base, "HS256")
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256")
  end

  def self.payload(token)
    decode(token).first
  end
end
