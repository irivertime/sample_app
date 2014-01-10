include ApplicationHelper
def sign_in(user)
  visit signin_path
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Вход без Capybara.
  cookies[:remember_token] = user.remember_token
end

def pagination_microposts
  it { should have_selector('div.pagination') }

  it "should list each user" do
    Micropost.paginate(page: 1).each do |micropost|
      page.should have_selector('li', text: micropost.content)
    end
  end
end