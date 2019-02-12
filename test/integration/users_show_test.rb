require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @unactivated_user = users(:lana)
    @activated_user   = users(:archer)
  end

  test "should redirect to root_url when user not activated" do
    log_in_as(@activated_user)
    get user_path(@unactivated_user)
    assert_redirected_to root_url
  end

end
