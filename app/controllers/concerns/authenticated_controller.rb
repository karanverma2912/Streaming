# app/controllers/concerns/authenticated_controller.rb
module AuthenticatedController
  extend ActiveSupport::Concern

  # Enable if we want to authenticate user for all actions
  # included do
  #   before_action :authenticate_user!
  # end

  private

  def authenticate_user!
    token = request.headers["Authorization"]&.split(" ")&.last
    return unauthorized unless token

    payload = JwtAuth.payload(token) rescue nil
    @current_user = User.find_by(id: payload["user_id"]) if payload

    unauthorized unless @current_user
  end

  def current_user
    @current_user
  end

  def unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end
end
