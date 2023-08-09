# test/models/url_test.rb
require 'test_helper'

class UrlTest < ActiveSupport::TestCase
  def setup
    Url.delete_all
  end

  test "should save a valid URL" do
    url = Url.new(original_url: "https://example.com")
    assert url.valid?
    assert url.save
  end

  test "should not save an invalid URL" do
    url = Url.new(original_url: "example.com")
    assert_not url.valid?
    assert_not url.save
  end

  test "should have a unique short code" do
    existing_url = Url.create(original_url: "https://example.com")
    url = Url.new(original_url: "https://example.org", short_code: existing_url.short_code)
    assert_not url.valid?
    assert_not url.save
  end
end
