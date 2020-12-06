class SnsCredential < ApplicationRecord
  belongs_to :user, optional: true # ユーザーモデルとの紐付け # oprional: 外部キーが無くても保存
end
