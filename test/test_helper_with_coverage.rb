require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/test/' # Exclude test files from coverage report
end

# Load the original test_helper.rb
require_relative 'test_helper'
