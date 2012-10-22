class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :email, type: String
  field :first_name, type: String
  field :last_name, type: String

  attr_protected :provider, :uid, :name, :email

  def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth['provider']
	    user.uid = auth['uid']
	    if auth['info']
	       user.name = auth['info']['name'] || ""
	       user.email = auth['info']['email'] || ""
	       user.first_name = auth['info']['first_name'] || ""
	       user.last_name = auth['info']['last_name'] || ""
	    end
	  end
	end
end
