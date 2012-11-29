class AddLinksTags < Mongoid::Migration
	def self.regenerate_slug(name)
		#strip the string
    ret = name.strip.downcase

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

		ret
	end

  def self.up
  	Tag.all.each do |tag|
  		tag.update_attributes slug: regenerate_slug(tag.name)
  	end

  	Link.all.each do |link|
  		if link.respond_to?(:tag_ids) && link.tag_ids.present?
  			link.tag_ids.each do |tag_id|
  				if link.tags.blank?
	  				tag = Tag.where(id: tag_id)
	  				if tag.exists?
	  					tag = tag.first
		  				link.add_to_set :tags, {id: tag.id, name: tag.name, slug: tag.slug} 
		  				link.save
		  			end
	  			end
				end
  		end
  	end
  end

  def self.down
  end
end