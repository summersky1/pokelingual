$VERBOSE=nil # hide selenium deprecated warning
require 'rails_helper'

RSpec.describe "autocomplete", type: :system do
  before do
    driven_by(:selenium_headless)
  end

  it "checks autocomplete suggestions" do
    visit '/en/search'
    expect(page).to have_no_css("div.easy-autocomplete-container")

    fill_in "search_box", with: "pik"
    execute_script("$('#search_box').focus()")
    expect(page).to have_css("div.easy-autocomplete-container")
    expect(page).to have_css("div.eac-item", text: "Pikachu")
  end

end
