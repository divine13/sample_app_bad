# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#


require 'spec_helper'

describe "User" do

 before do
  @user = User.new(name: "divine", email:"dube@example.com", password: "password", password_confirmation: "password"  )
  end 

   subject{@user}



   it { should respond_to(:name)}

   it {should respond_to(:email)}

   it {should respond_to(:remember_token)}

   it {should respond_to(:authenticate)}

   it { should respond_to(:microposts)}

   it {should respond_to(:password_digest)}

   it {should respond_to(:password)}

   it {should respond_to(:password_confirmation)}


   it {should be_valid}

   describe "user name can not be blank " do 
    before {@user.name = " "}
    it{should_not be_valid}
   end
   describe "email can not be blank" do
    before{(@user.email = " ")}
      it{should_not be_valid} 
   end

   describe "length of name can not be more than 50." do 
    before {(@user.name = "a" * 51)}
    it {should_not be_valid}
   end
      describe "when email is not valid" do
      it "description" do
        addresses = %w[user@foo,com user at foo.org example.user@foo. foo@bar baz.com foo@bar+baz.com]
         
         addresses.each   do |invalid_email|
           @user.email = invalid_email
           @user.should_not be_valid
      end
    end
  end
    describe "when email is valid " do
      it "should be valid" do
      addresse = %w[user@foo.COM A US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresse.each do |valid_email|
        email = valid_email
        should be_valid
      end
    end
  end
  describe "checking for dublicate email " do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.save
      user_with_same_email.email = @user.email.upcase
    end
    it {should_not be_valid}
  end
  describe "when password is empty" do
    before {@user.password = @user.password_confirmation = " "}
    it { should_not be_valid}
      
  end
  describe "checking for nil value"  do #no harm done just fool proof
  before{@user.password_confirmation = nil}
  it {should_not be_valid}
end

describe "return value of authenticate method" do
  before {@user.save}

    let(:found_user) { User.find_by_email(@user.email)}

    describe "with valid password" do
      it {should == found_user.authenticate(@user.password)}
    end

    describe "password not valid" do
      
     let(:user_invalid_pass){found_user.authenticate("invalid")}
     it {should_not == user_invalid_pass}
     specify {user_invalid_pass.should be_false}
    end

    describe "password can not be less than 5 letters" do
      before {@user.password = @user.password_confirmation = "a" * 5}
    end

end
describe "remember token" do
  
  
  before {@user.save}

  its(:remember_token) {should_not be_blank}
  end
  describe "microposts association" do
    before { @user.save }
    let!(:older_micropost) do
     FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
   end
   let!(:newer_micropost) do 
    FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
   end
   it "should have the right micropost in the correct order" do
    @user.microposts.should == [newer_micropost, older_micropost]
   end
   it "should destroy assciated microposts" do
    microposts = @user.microposts
    @user.destroy

    microposts.each do |micropost|
      Micropost.find_by_id(micropost.id).should be_nil
   end
  end
 end
end