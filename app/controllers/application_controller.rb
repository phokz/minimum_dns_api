class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: Rails.application.credentials.login,
                               password: Rails.application.credentials.password

  def empty
    render plain: ''
  end
end
