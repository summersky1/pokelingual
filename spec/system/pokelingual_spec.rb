require 'rails_helper'

RSpec.describe "Pokelingual", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "navbar" do
    it "contains links" do
      visit '/'
      expect(page).to have_link("Search", href: "/en/search")
      expect(page).to have_link("日本語", href: "/ja/search")
      (1..8).each do |gen|
        expect(page).to have_link(href: "/en/generation/#{gen}")
      end
    end

    context "in :ja locale" do
      it "contains link to :en locale" do
        visit '/ja/search'
        expect(page).to have_link("English", href: "/en/search")
      end
    end
  end

end
