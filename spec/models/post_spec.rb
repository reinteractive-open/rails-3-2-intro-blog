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

  describe '#content' do
    # Create a double of the MarkdownService
    let(:markdown_service) { double('MarkdownService') }

    before do
      # We don't want to use the actual MarkdownService
      # since it's tested elsewhere!
      MarkdownService.stub(:new) { markdown_service }
    end

    it 'should convert its body to markdown' do
      markdown_service.should_receive(:render).with('post body')
      Post.new(:body => 'post body').content
    end
  end

  describe '#author_name' do
    context 'when the author exists' do
      let(:author) { AdminUser.new }
      subject { Post.new(:author => author).author_name }

      before { author.stub(:name) { "Jane Smith" } }

      it { should eq "Jane Smith" }
    end

    context 'when the author doesnt exist' do
      subject { Post.new.author_name }

      it { should eq "Nobody" }
    end
  end

end
