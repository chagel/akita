class Authentication
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :binded_at, type: DateTime
  field :enabled, type: Boolean, default: true

  belongs_to :user, class_name: 'User'

  
end
