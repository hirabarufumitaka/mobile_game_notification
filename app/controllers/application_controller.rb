class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  before_action :basic

  def basic
    return unless Rails.env == 'production'

    authenticate_or_request_with_http_basic do |name, password|
      name == ENV['BASIC_AUTH_NAME'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
