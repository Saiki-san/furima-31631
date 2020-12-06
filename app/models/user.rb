class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise:database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable,
        :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  # アソシエーション
  has_many :items            # 1人のユーザーは、たくさんの商品を出品できる -->
  has_many :purchase_records # 1人のユーザーは、たくさんの商品を購入できる -->
  has_many :sns_credentials # sns管理モデルとの紐付け

  # バリデーション
  with_options presence: true do
    validates :nickname
    validates :birth_date
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "は全角で入力して下さい"} do # "Full-width characters"
      validates :firstname
      validates :lastname
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角(カナ)で入力して下さい"} do # "Full-width katakana characters"
      validates :firstname_reading
      validates :lastname_reading
    end

    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX #, message: 'には英字と数字の両方を含めて設定してください'
  end

  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email:    auth.info.email
    )
    # userが登録済みであるか判断
    if user.persisted?
    sns.user = user
    sns.save
    end
    { user: user, sns: sns }
  end
end