class ApplicationController < ActionController::Base
  before_action :basic_auth #Basic認証を事前実行(appContoroller内記載なので、全てのcontrollerに適用)
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      # username == 'admin' && password == '2222'
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # 環境変数を読み込む記述に変更
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :lastname, :firstname, :lastname_reading, :firstname_reading, :birth_date])
    end
  end
end
