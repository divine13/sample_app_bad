require "spec_helper"

describe ApplicationHelper do 
	describe "full_title" do
		it "should include the page title" do
			full_title("Home").should == "Happe | Home"
		end
		it "should not have illigal stuff" do
			full_title ('Home').should_not == "/\|/" 
		end
	end
end