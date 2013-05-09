require 'spec_helper'

describe MarkdownService do
  it { should be_a MarkdownService }

  describe '#render' do
    let(:content) { "anything" } # we don't care what content gets rendered

    # the markdown engine is just a test double we can monitor in our test
    let(:markdown_engine) { double('Markdown') }

    before do
      # Stub out the redcarpet markdown engine
      # In our test we can assume it works properly
      # since it's a well tested library.
      Redcarpet::Markdown.stub(:new) { markdown_engine }
    end

    it 'should delegate to the markdown engine' do
      # Set up the expectation of what our code should accomplish
      markdown_engine.should_receive(:render).with(content)
      MarkdownService.new.render(content)
    end
  end
end
