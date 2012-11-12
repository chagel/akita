class Tag
	include Mongoid::Document

	field :name, type: String
	field :slug, type: String
	field :links_count, type: Integer

	has_and_belongs_to_many :links

	before_create :generate_slug

	def update_count
		update_attribute :links_count, self.links.count
	end

	private
	def generate_slug
		#strip the string
    ret = self.name.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, & --> and, # --> sharp
    ret.gsub! /\s*#\s*/, " sharp "
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with slash
		ret.gsub! /\s*[^A-Za-z0-9\.]\s*/, '-'  

		#convert double slashs to single
		ret.gsub! /-+/,"-"

		#strip off leading/trailing slash
		ret.gsub! /\A[-\.]+|[-\.]+\z/,""

		self.slug = ret
	end
end