FactoryGirl.define do 
	factory :user do
     sequence(:name) { |n| "girl #{n}"}
     sequence(:email) { |n| "girl#{n}@factory.com"}
      password "foobar"
      password_confirmation "foobar"

      factory :admin do
      	admin true
      end
	end
	factory :micropost do
		content "lorem ipsum"
		user
	end
end
