require 'spec_helper'

feature 'Writing blog posts' do
  background do
    email = 'admin@example.com'
    password = 'password'
    @admin = AdminUser.create(:email => email, :password => password)

    log_in_admin_user
  end

  def log_in_admin_user(email = 'admin@example.com', password = 'password')
    reset_session!
    visit admin_root_path
    fill_in 'Email', :with => email
    fill_in 'Password', :with => password
    click_button 'Login'
  end

  scenario 'Writing a blog post in markdown' do
    click_link 'Posts'
    click_link 'New Post'

    fill_in 'post_title', :with => 'New Blog Post'
    fill_in 'post_body', :with => "[Example.com link](http://example.com/)"
    check 'post_published'
    click_button 'Create Post'

    visit post_path(Post.last)

    expect(page).to have_link 'Example.com link'
  end
end
