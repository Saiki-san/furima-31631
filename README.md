# テーブル設計
////////////////////////////////////////////////////////////////////////////////////

## users テーブル(ユーザー情報)[ユーザー管理機能]

| Column             | Type    | Options     |
| -------------------| ------- | ----------- |
| nickname           | string  | null: false | <!-- ニックネーム -->
| email              | string  | null: false | <!-- メールアドレス -->
| encrypted_password | string  | null: false | <!-- パスワード -->
| firstname_kanji    | string  | null: false | <!-- 苗字(全角) -->
| lastname_kanji     | string  | null: false | <!-- 名前(全角) -->
| firstname_katakana | string  | null: false | <!-- 苗字(全角カタカナ) -->
| lastname_katakana  | string  | null: false | <!-- 名前(全角カタカナ) -->
| birth_date         | date    | null: false | <!-- 誕生日(年月日) -->

### Association

- has_many :items            <!-- 1人のユーザーは、たくさんの商品を出品できる -->
- has_many :purchase_records <!-- 1人のユーザーは、たくさんの商品を購入できる -->
<!-- - has_many :comments         1人のユーザーは、たくさんのコメントを投稿できる -->
<!-- - has_many :rooms, through: room_users ←見本 -->

////////////////////////////////////////////////////////////////////////////////////

## items テーブル(商品情報)(商品出品機能)

| Column                     | Type       | Options                        |
| -------------------------- | ---------- | ------------------------------ |
| item_name                  | string     | null: false                    | <!-- 商品名 -->
<!-- | item_image                 | ActiveStorage  | null: false | 出品画像 ActiveStorageで実装する！ -->
| item_price                 | integer    | null: false                    | <!-- 販売価格 -->
| item_info                  | text       | null: false                    | <!-- 商品の説明 -->
| user                       | references | null: false, foreign_key: true | <!-- 出品者名(item_seller_name, nickname) -->
<!-- 以下はactiveh_hashにて実装の為、integer型・語尾に_idとする -->
| item_category_id           | integer    | null: false                    | <!-- 商品の詳細(カテゴリー) -->
| item_condition_id          | integer    | null: false                    | <!-- 商品の詳細(sales status,商品の状態) -->
| shipping_fee_burden_id     | integer    | null: false                    | <!-- 配送について(配送料の負担) -->
| shipping_prefecture_id     | integer    | null: false                    | <!-- 配送について(prefecture,県,発送元の地域) -->
| scheduled_shipping_date_id | integer    | null: false                    | <!-- 配送について(発送までの日数)(=scheduled delivery,発送予定日,発送日の目安) -->
| purchase_record            | references | null: false, foreign_key: true | <!-- (商品)と(購入記録)を紐付ける為のカラム -->

### Association

- belongs_to :user             <!-- 1つの(出品された)商品は、1人のユーザーによって出品される -->
- has_one    :purchase_record  <!-- 1つの(出品された)商品は、1つの購入記録 -->
<!-- - has_many   :comments         1つの(出品された)商品は、たくさんのコメントを持つ -->
<!-- - has_many   : -->

////////////////////////////////////////////////////////////////////////////////////

## purchase_records テーブル(購入記録purchase_record)[商品購入機能]

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true | <!-- 購入したユーザー -->
| item     | references | null: false, foreign_key: true | <!-- 購入された商品 -->
<!-- | buy_date | date       | null: false                    | 購入した年月日 【不要！！！】-->

### Association
- belongs_to :item <!-- 1回の購入記録は、1つの商品につき1カウントだけ -->
- belongs_to :user <!-- 1回の購入記録は、1人のユーザーによってカウントされる -->
- has_one    :shipping_address <!-- 1回の購入記録は、1つの配送先 -->

////////////////////////////////////////////////////////////////////////////////////

## shipping_addresses テーブル(住所street_address)[商品購入機能]

| Column                | Type    | Options     |
| --------------------- | ------- | ----------- |
| postal_code           | integer | null: false | <!-- 配送先(郵便番号) -->
| prefecture_id         | integer | null: false | <!-- 配送先(都道府県) activeh_hashにて実装の為、integer型・語尾に_idとする-->
| city                  | string  | null: false | <!-- 配送先(市区町村) -->
| house_number          | string  | null: false | <!-- 配送先(丁目・番地・号) -->
| building_name         | string  | ----------- | <!-- 配送先(建物名) -->
| phone_number          | string  | null: false | <!-- 配送先(電話番号) integerだと先頭の0が消えてしまう為、string型とする-->

### Association
- belongs_to :purchase_record <!-- 1つの配送先は、1回の購入記録につき1つ -->
<!-- - has_one :item            1つの配送先は、1つの商品につき1つ 【不要！！！！】-->

////////////////////////////////////////////////////////////////////////////////////

<!-- ## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
| text   | string     | null: false                    |

### Association

<!-- belongs_to :item itemsテーブルとのアソシエーション -->
<!-- - belongs_to :user usersテーブルとのアソシエーション -->

////////////////////////////////////////////////////////////////////////////////////

<!-- 使用禁止！！！！！！！ -->
<!-- ## credits テーブル(クレジット情報)[商品購入機能] -->
<!-- | Column                | Type    | Options     | -->
<!-- | --------------------- | ------- | ----------- | <!-- クレジット = token > -->
<!-- | credit_card_number    | integer | null: false | クレジットカード情報(カード情報(番号)) -->
<!-- | expiration_date_month | integer | null: false | クレジットカード情報(有効期限(月)) -->
<!-- | expiration_date_year  | integer | null: false | クレジットカード情報(有効期限(年)) -->
<!-- | security_code         | integer | null: false | クレジットカード情報(有効期限(年)) -->

<!-- ### Association -->

<!-- - belongs_to :users 1つの(出品された)商品は、1人のユーザーによって出品される -->
<!-- - belongs_to :items 1つの(出品された)商品は、1人のユーザーによって購入される -->

////////////////////////////////////////////////////////////////////////////////////

メモ・確認用
viewsディレクトリ内の詳細
| ディレクトリ            | ファイル名                 | 詳細                                 |
| --------------------- | ------------------------ | ------------------------------------ |
| devise/registrations  | new.html.erb             | ユーザー新規登録ページ                   |
| devise/sessions       | new.html.erb             | ユーザーログインページ                   |
| items                 | edit.html.erb            | 商品を編集するページ                     |
|                       | index.html.erb           | トップページ                           |
|                       | new.html.erb             | 商品を出品するページ                     |
|                       | show.html.erb            | 商品の詳細を確認するページ                |
| layouts               | application.html.erb     | レイアウトファイル                       |
| shared                | _error_messages.html.erb | エラーメッセージ                        |
|                       | _footer.html.erb         | トップページ・商品詳細フッター             |
|                       | _header.html.erb         | トップページ・詳細ヘッダー                |
|                       | _second-footer.html.erb  | ユーザー新規登録・ログイン・商品購入フッター |
|                       | _second-header.html.erb  | ユーザー新規登録・ログイン・商品購入ヘッダー |
| orders                | index.html.erb           | 商品を購入する時のページ                  |

| カード番号         | 有効期限 | CVC |
| ---------------- | ------- | --- |
| 4242424242424242 | 12/24   | 123 |