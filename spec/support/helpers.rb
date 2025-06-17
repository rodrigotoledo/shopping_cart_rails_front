# frozen_string_literal: true

require 'rails-controller-testing'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

Rails::Controller::Testing.install
