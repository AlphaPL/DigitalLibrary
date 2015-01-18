require 'test_helper'

class SearchBooksControllerTest < ActionController::TestCase

  def setup
    Book.tire.index.delete
    Book.import
    Book.tire.index.refresh
  end

  test "should get contact" do
    get :search, :genre_id => '0', :q => 'Drach'
    assert_response :success
  end
  
end
