# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Micropost do
 let(:user) { FactoryGirl.create(:user) }
 before { @micropost = user.microposts.build(content: "lorem ipsum") }

 subject {@micropost}
 it {should respond_to(:content)}
 it { should respond_to(:user_id)}

 it {should be_valid}

 describe "when user id is nil" do
 	before { @micropost.user_id = nil}
 	it {should_not be_valid}
 end
 describe "accessible methods" do
  it "should not allow access to user_id" do
  	expect do
  			Micropost.new(user_id: user.id)
  			
  		  end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
  	    end
  	end
  	describe "cant have an empty micropost" do
  	before { @micropost.content = " "}
  	it {should_not be_valid}
  end

  describe "user id can not be nil " do 
  	before { @micropost.user_id = nil}
  	it { should_not be_valid }
  end
  describe "if content id too long it should not be valid" do
  	before { @micropost.content = "a" * 141 }
  	it {should_not be_valid}
  	end
end
