#encoding: utf-8
class Invite
	include Mongoid::Document
	include Mongoid::Timestamps
	field :code, type: String
	field :invited_email, type: String
	field :invited_at, type: Time
	field :activated_user_id, type: String
	field :activated_at, type: Time

	belongs_to :user

	validates_uniqueness_of :code
	validates_presence_of :code

	after_save :update_user_state

	scope :available, where(activated_user_id: nil, activated_at: nil)

	private
	def update_user_state
		if self.activated_user_id_changed? 
			User.find(self.activated_user_id).update_attributes state: 'invited'
		end
	end

end