require 'test_helper'

class UrlsControllerTest < ActionDispatch::IntegrationTest
  setup do
    Url.delete_all
    @credentials = ActionController::HttpAuthentication::Basic.encode_credentials('hello', '123')
  end

  test "should create a new URL" do
    post urls_url, params: { url: { original_url: 'https://example.com' } }, headers: { 'Authorization' => @credentials }
    assert_response :created
    assert JSON.parse(response.body).key?('short_url')
  end

  test "should redirect to the original URL" do
    url = Url.create(original_url: 'https://example.com')
    get "/#{url.short_code}", headers: { 'Authorization' => @credentials }, params: { url: url.original_url }
    assert_response :redirect
    assert_redirected_to url.original_url
  end

  test "should handle URL not found" do
    get "/invalid_short_code", headers: { 'Authorization' => @credentials }
    assert_response :not_found
    assert_equal 'URL not found', response.body
  end

  test "should return a list of URLs" do
    Url.delete_all
    Url.create(original_url: 'https://example.com')
    Url.create(original_url: 'https://example.org')
    get urls_url, headers: { 'Authorization' => @credentials }
    assert_response :ok
    assert_operator JSON.parse(response.body).size, :>=, 1
  end

  test "should handle invalid URL creation" do
    post urls_url, params: { url: { original_url: "123" } }, headers: { 'Authorization' => @credentials }
    assert_response :unprocessable_entity
    assert JSON.parse(response.body).key?('errors')
  end
end
