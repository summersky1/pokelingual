require 'rails_helper'

RSpec.describe "Pokelingual", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "navbar" do
    it "contains links" do
      visit '/'
      expect(page).to have_link("About", href: "/en/about")
      expect(page).to have_link("日本語", href: "/ja/about")
      expect(page).to have_link("Search", href: "/en/search")
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

  describe "search" do
    it "enables user to search for Pokemon" do
      visit '/en/search'
      expect(page).to have_css("div.pokemon-card")

      fill_in "query", with: "pikachu"
      click_button "search_button"
      expect(page).to have_css("div.card-text-large", text: "Pikachu")
    end
  end

end
