class Address < ApplicationRecord
  belongs_to :order
  extend ActiveHash::Associations::ActiveRecordExtensions # ActiveHashを用いて、belongs_toを設定。module取り込み
  belongs_to :prefecture # addressは1つのprefectureに紐づいている
end