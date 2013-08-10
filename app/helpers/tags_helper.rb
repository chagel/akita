module TagsHelper
	def render_list_tags(list)
		html = ''
		list.tags.each do |tag|
      html << link_to(tag[:name]||tag['name'], '#', class: 'tag')
    end

    html.html_safe
	end

	def plain_list_tags(list)
		text = ''
		list.tags.each do |tag|
      text << "##{tag[:name]||tag['name']}# "
    end

    text
	end

end
