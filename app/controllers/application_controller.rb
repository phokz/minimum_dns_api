class ApplicationController < ActionController::Base
  http_basic_authenticate_with name: Rails.application.secrets.login,
                               password: Rails.application.secrets.password

  def empty
    render plain: ''
  end
end
