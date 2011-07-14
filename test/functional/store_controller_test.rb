require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    #Gets index page, in this case /store
    get :index
    assert_response :success
    #Different from Rspec - put multiple asserts in the same test
    #Tests for an element 'a' that is contained in in an element of id #side that is contained in #columns. This is actually a weird test for the four nav columns.
    assert_select '#columns #side a', :minimum => 4
    #Tests for having 3 .entry elements inside #main - basically at least 3 products
    assert_select '#main .entry', 3
    #Tests for title of the page
    assert_select 'h3', 'Programming Ruby 1.9'
    #Tests with regular expressions that price is formatted correctly
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
end
