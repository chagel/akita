class Apply
  include Mongoid::Document
  include Mongoid::Timestamps
  field :email, type: String
  field :description, type: String
  field :code, type: String

  validates :email, 
            :presence => true, 
            :uniqueness => {:message => "is already on my list. Please be patient."}, 
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

end
