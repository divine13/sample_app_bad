require 'spec_helper'

describe "static pages" do 

let(:base_title) {"Happe"}
     
    subject{page}

    shared_examples_for "all static pages" do
      it {should have_selector('h1', text: heading)}
      it {should have_selector('title', text: full_title(page_title) )}
    end

  describe "home page" do         #START OF DESCRIBE HOME PAGE 

    before{visit root_path}
      let(:heading) {'Welcome to Happe!'}
      let(:page_title) {'Home'}

     it_should_behave_like "all static pages"
     it{should_not have_selector('title', text: "|Home")}

     it "should have the right links" do
     visit root_path
     click_link "About"
     page.should have_selector('h1', text: "About Us")
     click_link "Contact"
     page.should have_selector('h1',text: "Contacts")
     click_link "Help"
     page.should have_selector('h1',text: "Help")
   end
  end                              #END OF DESCRIBE HOME PAGE

  describe "help page" do                     #START OF DESCRIBE HELP PAGE

    before{visit help_path}

    let(:heading) { "Help" }
    let (:page_title){'Help'}

    it_should_behave_like "all static pages"

 	end                                          #END OF DESCRIBE HELP PAGE
 	describe "about us page" do

      before{visit about_path}

      let(:heading){"About Us"}
      let(:page_title){ 'About' }

 	    it_should_behave_like "all static pages"
 		end
  describe "contacts page" do
    before{ visit contact_path}
  
      let(:heading){"Contacts"}
      let(:page_title){ 'Contacts' }

      it_should_behave_like "all static pages"

  end	
 end