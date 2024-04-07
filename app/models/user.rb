class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         #devise ユーザー認証や登録、パスワードの再設定などを簡単に扱うためのコード
         #database_authenticatable` は、デバイスがユーザーをデータベースに保存し、パスワード認証を行う設定です。ユーザーがログインする際には、デバイスはユーザー名またはメールアドレスとパスワードをチェックして、認証を通過させます。
         #registerable` は、デバイスがユーザーの登録処理を行えるようにする設定です。ユーザーが新しくアカウントを作成する際に、デバイスは必要な情報を収集し、データベースに新しいユーザーを作成
         #recoverable` は、デバイスがユーザーのパスワードを再設定できるようにする設定です。ユーザーがパスワードを忘れた場合、デバイスはリセットトークン（reset token）を生成し、それを使って新しいパスワードを設定する手段を提供します。
         #rememberable` は、デバイスがログイン情報を記憶できるようにする設定です。ユーザーがログインした後でも、一定期間（デフォルトでは2週間）ログイン情報を保持しておき、自動的にログインできるようにします。
         #validatable` は、デバイスがユーザーの入力値を検証できるようにする設定。これにより、ユーザー名やメールアドレスの一意性チェックや、パスワードの長さ・形式などのバリデーションを自動的に行うことが可能。
validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
#uniqueness: true：一意性を保証するためには、Railsのユニーク制約を使用するか、自分で一意性をチェックする必要があ流ため記載
validates :introduction, length: { maximum: 50 }

  has_many :books
  # booksと紐づけるため

    has_one_attached :profile_image #

  def get_profile_image(width, height)
  unless profile_image.attached? #どこのプロフィール画像か
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
