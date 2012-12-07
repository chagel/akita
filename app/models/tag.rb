class Tag
	include Mongoid::Document

	field :name, type: String
	field :slug, type: String
	field :links_count, type: Integer
	field :lists_count, type: Integer

	index slug: 1

	before_create :generate_slug

	def refresh_links_count
		self.update_attributes links_count: Link.where("tags.id" => self.id).count
	end

	def refresh_sets_count
		self.update_attributes lists_count: List.where("tags.id" => self.id).count
	end

	private
	def generate_slug
		#strip the string
    ret = self.name.strip.downcase

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, & --> and, # --> sharp
    ret.gsub! /\s*#\s*/, " sharp "
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, chineses, underscore or periods with slash
		ret.gsub! /\s*[^A-Za-z0-9\.\u4e00-\u9fa5]\s*/, '-'  

		#convert double slashs to single
		ret.gsub! /-+/,"-"

		#strip off leading/trailing slash
		ret.gsub! /\A[-\.]+|[-\.]+\z/,""

		self.slug = ret
	end
end