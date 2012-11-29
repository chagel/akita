class Favorite
    include Mongoid::Document
    include Mongoid::Timestamps
    belongs_to :user
    belongs_to :link
end

class AddUsersFavorites < Mongoid::Migration
  def self.up
  	Favorite.all.each do |favorite|
			if favorite.link.favorites.blank? || !favorite.link.favorites.include?(favorite.user.id)
				favorite.link.add_to_set :favorites, favorite.user.id
			end
			favorite.link.save
  	end
  end

  def self.down
  end
end