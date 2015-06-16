class User
  include ActiveModel::Model
  attr_accessor :id, :email, :nickname, :token
end