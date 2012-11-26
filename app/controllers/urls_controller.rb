require 'open-uri'
class UrlsController < ApplicationController
	before_filter :authenticate_user!
	
	def create
		if params[:id] =~ /^[http|https]/
			begin
				puts "#{Time.now} => Fetching url[#{params[:id]}] "
				doc = Nokogiri::HTML(open(params[:id]))
				doc.xpath('//head/title').each do |title|
					puts "#{Time.now} => End"
				  render :json => {"title" =>  title.content }.to_json and return
				end
			rescue Exception => ex
				render :json => {"error" => "#{ex}"}.to_json and return
			end
		end
		render :json => {"error" => "please check the url"}.to_json
	end

end
