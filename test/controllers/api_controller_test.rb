require 'test_helper'

# curl -iX POST http://localhost:4000/widget -d @test/fixtures/requests/sample.json -H "Content-Type: application/json"
class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should return api.js" do
    payload = JSON.parse File.read(Rails.root.join('test', 'fixtures', 'requests', 'sample.json'))
    get api_url(format: :js, params: payload)
    assert_response :success
  end
end