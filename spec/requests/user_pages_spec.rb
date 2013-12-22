require 'spec_helper'

describe "User pages" do

  subject { page }
  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign up') }
    it { should have_selector('title', text: 'Sign up') }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',    text: user.name) }
    it { should have_selector('title', text: user.name) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Create my account" }


    let(:name_blank) { "Name can't be blank" }
    let(:name_long) { "Name is too long (maximum is 50 characters)" }
    let(:email_blank) { "Email can't be blank" }
    let(:email_invalid) { "Email is invalid" }
    let(:email_taken) { "Email has already been taken" }
    let(:pass_blank) { "Password can't be blank" }
    let(:pass_short) { "Password is too short (minimum is 6 characters)" }
    let(:conf_blank) { "Password confirmation can't be blank" }
    let(:pass_match) { "Password doesn't match confirmation" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
        before { click_button submit }

        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end

      describe "after submission (only name)" do
        before do
          fill_in "Name",         with: "Example User"
        end
        before { click_button submit }

        it { should have_content(email_blank) }
        it { should have_content(email_invalid) }
        it { should have_content(pass_blank) }
        it { should have_content(pass_short) }
        it { should have_content(conf_blank) }

        it { should_not have_content(name_blank) }
        it { should_not have_content(name_long) }
        it { should_not have_content(email_taken) }
        it { should_not have_content(pass_match) }
      end
      describe "after submission (name blank, email invalid, pass short )" do
        before do
          fill_in "Email",        with: "user@invalid"
          fill_in "Password",     with: "foo"
        end
        before { click_button submit }

        it { should have_content(name_blank) }
        it { should have_content(email_invalid) }
        it { should have_content(pass_short) }
        it { should have_content(conf_blank) }
        it { should have_content(pass_match) }

        it { should_not have_content(name_long) }
        it { should_not have_content(email_blank) }
        it { should_not have_content(email_taken) }
        it { should_not have_content(pass_blank) }

      end
      describe "after submission (name long, email taken, pass match )" do
        let(:user) { FactoryGirl.create(:user) }

        before do
          fill_in "Name",         with: "a"*51
          fill_in "Email",        with: user.email
          fill_in "Password",     with: "foobar"
          fill_in "Confirmation", with: "barfoo"
        end
        before { click_button submit }

        it { should have_content(name_long) }
        it { should have_content(email_taken) }
        it { should have_content(pass_match) }

        it { should_not have_content(name_blank) }
        it { should_not have_content(email_blank) }
        it { should_not have_content(email_invalid) }
        it { should_not have_content(pass_blank) }
        it { should_not have_content(pass_short) }
        it { should_not have_content(conf_blank) }


      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('user@example.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }

        it { should have_link('Sign out') }
      end

    end
  end

end
