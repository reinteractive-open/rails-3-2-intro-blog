require 'spec_helper'

feature 'Posting Comments' do
  background do
    @post = Post.create(:title => 'Awesome Blog Post', :body => 'Lorem ipsum dolor sit amet', :published => true)
  end

  # Note this scenario doesn't test the AJAX comment posting.
  scenario 'Posting a comment' do
    visit post_path(@post)

    comment = 'This post is just filler text. Ripped off!'

    fill_in 'comment_body', :with => comment
    click_button 'Add comment'

    expect(page).to have_content comment
  end
end
