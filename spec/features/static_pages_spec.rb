require 'spec_helper'

feature 'Browsing Static Pages' do
  context 'the about page' do
    scenario 'it is browseable from the header' do
      visit root_path

      click_link 'About me'

      expect(page.status_code).to eq 200
    end
  end
end
