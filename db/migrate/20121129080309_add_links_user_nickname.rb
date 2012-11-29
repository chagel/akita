class AddLinksUserNickname < Mongoid::Migration
  def self.up
  	Link.all.each do |link|
  		if link.user_nickname.blank?
  			link.update_attributes user_nickname: User.find(link.user_id).nickname
  		end
  	end
  end

  def self.down
  end
end