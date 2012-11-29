#encoding: utf-8
require 'digest'

class Link
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :url, type: String
	field :description, type: String
	field :favorites, type: Array
	
	field :user_nickname, type: String

	belongs_to :user
	has_one :link_stats, class_name: 'LinkStats', dependent: :destroy
	has_and_belongs_to_many :tags

	validates_presence_of :title, :url
	validates_uniqueness_of :url
	validates_format_of :url, :with => URI::regexp(%w(http https))

	after_save :update_tags_count
	before_create :assign_extra

	def domain
		self.url.match /(\w*\.[a-z.0-9-]*)/
	end

	def visit!
		LinkStats.find_or_create_by(link_id: self.id).inc :clicks, 1
	end

	def vote!
		LinkStats.find_or_create_by(link_id: self.id).inc :votes, 1
	end

	private
	def update_tags_count
		self.tags.each do |tag|
			tag.update_count 
		end
	end

	def assign_extra
		self.user_nickname = User.find(self.user_id).nickname
	end

end