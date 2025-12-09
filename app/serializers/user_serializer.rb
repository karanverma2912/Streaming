class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :username, :role, :created_at
end
