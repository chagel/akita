#encoding: utf-8
require 'digest'

class Link
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :url, type: String
	field :description, type: String
	field :favorites, type: Array
	field :tag_names, type: String
	field :tags, type: Array
	field :user_nickname, type: String

	index favorites: 1
	index tags: 1

	belongs_to :user
	has_one :link_stats, class_name: 'LinkStats', dependent: :destroy

	validates_presence_of :title, :url
	validates_uniqueness_of :url
	validates_format_of :url, :with => URI::regexp(%w(http https))

	after_save :update_tags_count
	before_create :assign_user_nickname
	before_save :find_or_create_tags

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
			Tag.find(tag[:id]).refresh_links_count if tag && tag[:id]
		end if self.tags.present?
	end

	def find_or_create_tags
		if self.tag_names.present? && self.tag_names_changed?
			self.tags = []
			self.tag_names.split(/[,|，|\s]/).each do |name|
				tag = Tag.find_or_create_by(name: name.strip.downcase)
				self.tags << {id: tag.id, slug: tag.slug, name: tag.name}
			end 
		end
	end

	def assign_user_nickname
		self.user_nickname = User.find(self.user_id).nickname
	end

end