#encoding: utf-8
require 'digest'

class List
	include Mongoid::Document
	include Mongoid::Timestamps
	field :title, type: String
	field :urls, type: Array, default: Array.new(3)
	field :tag_names, type: String
	field :tags, type: Array	
	field :user_nickname, type: String

	index tags: 1

	belongs_to :user

	validates_presence_of :title
	before_validation :verify_urls

	after_save :update_tags_count
	before_create :assign_user_nickname
	before_save :find_or_create_tags
	before_save :reject_blank_urls

	def self.domain(fullurl)
		fullurl.match /(\w*\.[a-z.0-9-]*)/ if fullurl.is_a? String
	end

	private
	def update_tags_count
		self.tags.each do |tag|
			Tag.find(tag[:id]).refresh_sets_count if tag && tag[:id]
		end if self.tags.present?
	end

	def find_or_create_tags
		if self.tag_names.present? && self.tag_names_changed?
			self.tags = []
			self.tag_names.split(/[,|，|\s]/).each do |name|
				tag = Tag.find_or_create_by(name: name.strip)
				self.tags << {id: tag.id, slug: tag.slug, name: tag.name}
			end 
		end
	end

	def assign_user_nickname
		self.user_nickname = User.find(self.user_id).nickname
	end

	def reject_blank_urls
		self.urls.delete_if {|url| url.blank? }
	end

	def verify_urls
		self.errors.add :urls, 'must have one url at least' if self.urls.blank?
		self.urls.each do |url|
			self.errors.add :urls, 'url is invalid' if !url.match(/^(http|https):/) && url.present?
		end
	end

end