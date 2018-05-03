require 'test_helper'

# curl -iX POST http://localhost:4000/widget -d @test/fixtures/requests/sample.json -H "Content-Type: application/json"
class WidgetsControllerTest < ActionDispatch::IntegrationTest
  test "should response with sample widget" do
    get widget_url(name: 'Sample')
    assert_response :success
  end
end
