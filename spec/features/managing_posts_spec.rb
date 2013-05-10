require 'spec_helper'

feature 'Managing blog posts' do
  scenario 'Guests cannot create posts' do
    visit root_path
    expect(page).to_not have_link 'New Post'
  end

  context 'as an admin user' do
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

    scenario 'Posting a new blog' do
      click_link 'Posts'
      click_link 'New Post'

      fill_in 'post_title', :with => 'New Blog Post'
      fill_in 'post_body', :with => 'This post was made from the Admin Interface'
      click_button 'Create Post'

      expect(page).to have_content 'This post was made from the Admin Interface'
    end

    context 'with an existing blog post' do
      background do
        @post = Post.create(:title => 'Awesome Blog Post', :body => 'Lorem ipsum dolor sit amet')
      end

      scenario 'Editing an existing blog' do
        visit admin_post_path(@post)

        click_link 'Edit'

        fill_in 'Title', :with => 'Not really Awesome Blog Post'
        click_button 'Update Post'

        expect(page).to have_content 'Not really Awesome Blog Post'
      end

      scenario 'Publishing an existing blog' do
        visit admin_post_path(@post)
        click_link 'Edit Post'

        check 'post_published'
        click_button 'Update Post'

        expect(page).to have_content 'Post was successfully updated'
        expect(Post.last.published?).to be_true
      end
    end
  end
end
