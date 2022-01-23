require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest # rubocop:disable Metrics/ClassLength

  # custom
  test "should be able to get daily sales" do
    get('/')
    assert_response :success
    actual_response = Loofah.fragment(response.body).to_text
    expected_response = Loofah.fragment(File.read(Rails.root + 'test/static/response/home_page.txt')).to_text
    assert_equal expected_response, actual_response, 'response does not match'
  end

end
