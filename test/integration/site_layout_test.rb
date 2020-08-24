require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test 'navbar links' do
    get '/en/search'
    assert_template 'pokemon/search'
    assert_select 'a[href=?]', '/en/search', count: 2
    assert_select 'a[href=?]', '/ja/search'
    (1..8).each do |gen|
      assert_select 'a[href=?]', "/en/generation/#{gen}"
    end
  end
  
end
