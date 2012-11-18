require 'open-uri'
class UrlsController < ApplicationController
	before_filter :authenticate_user!
	
	def create
		if params[:id] =~ /^[http|https]/
			begin
				doc = Nokogiri::HTML(open(params[:id]))
				doc.xpath('//head/title').each do |title|
				  render :json => {:title =>  title.content }.to_json and return
				end

			rescue Exception => ex
				render :json => {:error => "#{ex}"}.to_json
			end
		end
	end

end
