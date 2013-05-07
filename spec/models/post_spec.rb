require 'spec_helper'

describe Post do
  describe 'validations' do
    subject(:post) { Post.new } # sets the subject of this describe block
    before { post.valid? }      # runs a precondition for the test/s

    [:title, :body].each do |attribute|
      it "should validate presence of #{attribute}" do
        expect(post).to have_at_least(1).error_on(attribute)
        expect(post.errors.messages[attribute]).to include "can't be blank"
      end
    end
  end
end
