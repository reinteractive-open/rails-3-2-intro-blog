require 'spec_helper'

feature 'Reading the Blog' do
  context 'for an unpublished post' do
    background do
      @post = Post.create(:title => 'Unpublished Post', :body => 'Lorem ipsum dolor sit amet')
    end

    scenario 'it does not appear in the index' do
      visit root_path

      expect(page).to_not have_content 'Unpublished Post'
    end

    scenario 'it cannot be visited directly' do
      expect(lambda {
        visit post_path(@post)
      }).to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'for a published post' do
    background do
      email = 'admin@example.com'
      password = 'password'
      @admin = AdminUser.create(:email => email, :password => password)

      @post = Post.create(:title => 'Awesome Blog Post', :body => 'Lorem ipsum dolor sit amet', :published => true, :author => @admin)
      Post.create(:title => 'Another Awesome Post', :body => 'Lorem ipsum dolor sit amet', :published => true, :author => @admin)
    end

    scenario 'Reading the blog index' do
      visit root_path

      expect(page).to have_content 'Awesome Blog Post'
      expect(page).to have_content 'Another Awesome Post'
      expect(page).to have_content 'Posted by: admin@example.com'
    end

    scenario 'Reading an individual blog' do
      visit root_path
      click_link 'Awesome Blog Post'

      expect(current_path).to eq post_path(@post)
    end
  end
end
