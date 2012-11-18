class LinkStats
	include Mongoid::Document
	field :clicks, type: Integer, default: 0
	field :votes, type: Integer, default: 0

	belongs_to :link
end