#coding: utf-8

namespace :invite do
  desc "Generate 1000 codes"
  task :generate => :environment do |t, args|
  	SecureRandom.base64
		(1..1000).each do |i|
			Invite.create :code => SecureRandom.urlsafe_base64
		end
  end

  desc "Give everyone 3 invites"
  task :assign_everyone => :environment do 
  	User.each do |user|
  		if user.invites.available.count == 0
		  	Invite.available.where(user: nil).limit(3).each do |invite|
		  		invite.update_attributes! user: user
		  	end
		  end
	  end
  end

  desc "Give moderator 20 invites"
  task :assign_moderator => :environment do 
  	Moderator.each do |moderator|
  		if user = User.find_by(email: moderator.email)
		  	Invite.available.where(user: nil).limit(20).each do |invite|
		  		invite.update_attributes! user: user
		  	end
		  end
	  end
  end
end