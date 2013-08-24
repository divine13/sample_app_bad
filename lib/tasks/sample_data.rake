namespace :db do 

	desc "fill data base with some data"

     task populate: :environment do

     	make_users
     	make_microposts
     	make_relationships
	
     end
end
  def make_users
	admins = User.create!(name: "divine", email: "dube@mail.com", password: "123456", password_confirmation:"123456")
	admins.toggle!(:admin)
	 99.times do |n|
	 	name = Faker::Name.name

        emazil = "ubee-#{n + 1}@mal.com" 
	 	password = "023456"

	 	User.create!(name: name, email: emazil, password: password, password_confirmation: password)
	 end
 end

 def make_microposts
 	 users = User.all(limit: 6)
     50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
 end
end

def make_relationships
	users = User.all
	user = User.first

	followed_users = users[2..50]
	followers = users[3..40]

	followed_users.each { |followed| user.follow!(followed)  } 

	followers.each { |follower| follower.follow!(user)  }

end