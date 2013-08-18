require 'spec_helper'

describe "UserPages" do

	subject{page}

  describe "user pages" do

    describe "index" do
      #i will come back to this when i get time  lets do some hardcore stuff,the real thing
    end
   before{visit new_user_path}
    
    it{ should have_selector('h1', text: 'Sign Up')}
     it{should have_selector('title', text: full_title(''))}
     let(:submit) { "Create Account" }

     describe "submitted invalid information" do
      it "should reject" do
        expect { click_button submit }.not_to change(User, :count)
      end
      describe "after submition" do 
        before {click_button submit}
        it {should have_selector('h1',text: "Sign Up")}
        it{ should have_content("error")}
      end
     end
     describe "submitting valid information" do
      before do
        fill_in "Name",          with: "divine"
        fill_in "Email",         with: "divine@mail.com"
        fill_in "Password",      with: "foobar"
        fill_in "Confirmation",  with: "foobar"
      end
      it "should create a user" do
        expect{ click_button submit }.to change(User, :count).by(1)
      end
      describe "after a user has been created " do 
        before {click_button submit}
        let(:user) { User.find_by_email("divine@mail.com") }

        it{should have_selector('title', text:  user.name)}
        it{should have_selector('div.alert.alert-success', text: "welcome")}
        end
     end
  end
  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }

      let(:user) { FactoryGirl.create(:user) }
      let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "foo")}
      let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "bars")}

     	before {visit user_path(user)}
  
  	  it {should  have_selector("h1", text: user.name)}
  	  it {should have_selector("title", text: user.name)}

      describe "microposts" do
        it {should have_content(m1.content)}
        it {should have_content(m2.content)}

        it {should have_content(user.microposts.count)}
      end
  end
  describe "if no user is signed" do
    it {should_not have_selector("h1", text: "Users")}

end
describe "edit" do
  let(:user) { FactoryGirl.create(:user)}
  before do 
    sign_in user
  visit edit_user_path(user)
end
  describe "page" do 
    it{should have_selector('h1', text: "Update your profile")}
    it{should have_selector('title', text: "Edit profile")}
    it{should have_link("change", href: "divine.jpg")}
  end
  describe "with invalid information" do
  before {click_button "Save changes"}

  it {should have_content("error")}
     end
     describe "with valid info" do

      let(:new_name) { "divine" }
      let(:new_email) { "dube@mail.com" }

      before do
      fill_in "Name", with: new_name
      fill_in "Email", with: new_email

      fill_in "Password", with: user.password
      fill_in "Confirm Password", with: user.password 

      click_button "Save changes"
      end
      it{should have_selector('title', text: new_name)}
      it{should have_selector("div.alert.alert-success")}
      it{should have_link('Sign out', href: signout_path)}

      specify{user.reload.name.should == new_name}
      specify{user.reload.email.should == new_email}
     end
  end
end
