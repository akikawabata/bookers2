class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]#exceptログイン系の表示がされないように
  # 全てのコントローラログインしているかどうか確認するされたユーザーかどうかを
  #未ログイン認証状態でトップページ以外の画面にアクセスしても、ログイン画面へリダイレクト。 また、ログイン認証が済んでいる場合には全てのページにアクセスすることができます
  #before_actionメソッドは最初にbefore_actionメソッドが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path#ログアウト機能が動いたときにルートパスに遷移するという意味
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    # `:name`と`:email`のパラメータを許可する
    #sanitizerはユーザー作成時に使用されるパラメータを許可する役割
  end
end