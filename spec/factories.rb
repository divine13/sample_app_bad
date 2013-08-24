FactoryGirl.define do 
	factory :user do
     #s#equence(:name) { |n| "girl#{n}1"}
    # sequence(:email) { |n| "girl#{n}@factory.com"}
    name "divine"
    email "dubes@mail.dub"
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
