class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise:database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :items            # 1人のユーザーは、たくさんの商品を出品できる -->
  has_many :purchase_records # 1人のユーザーは、たくさんの商品を購入できる -->

  with_options presence: true do
    validates :nickname
    validates :birth_date
    with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "Full-width characters"} do
      validates :firstname
      validates :lastname
    end
    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: "Full-width katakana characters"} do
      validates :firstname_reading
      validates :lastname_reading
    end

    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
    validates_format_of :password, with: PASSWORD_REGEX #, message: 'には英字と数字の両方を含めて設定してください'
  end

end
