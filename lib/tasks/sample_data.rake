namespace :db do 

	desc "fill data base with some data"

	task populate: :environment do
	admins = User.create!(name: "divine", email: "dube@mail.com", password: "123456", password_confirmation:"123456")
	admins.toggle!(:admin)
	 99.times do |n|
	 	name = Faker::Name.name

        emazil = "ubee-#{n}@mal.com" 
	 	password = "023456"

	 	User.create!(name: name, email: emazil, password: password, password_confirmation: password)
	 end
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
     end
   end
end
