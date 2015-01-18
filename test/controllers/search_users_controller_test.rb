require 'test_helper'

class SearchUsersControllerTest < ActionController::TestCase

  def setup
    User.tire.index.delete
    User.import
    User.tire.index.refresh
  end

  test "should get contact" do
    get :search, :q => 'Arek'
    assert_response :success
  end
  
end