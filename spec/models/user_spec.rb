require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '#create(ユーザー新規登録)' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemail、lastnameとfirstname、lastname_readingとlastname_reading、
          passwordとpassword_confirmationが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください") # "Nickname can't be blank"
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください") # "Email can't be blank"
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します") # "Email has already been taken"
      end
      it "emailに@が含まれていない場合登録できない" do
        @user.email = "abcdefg"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です") # "Email is invalid"
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください") # "Password can't be blank"
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "aa000"
        @user.password_confirmation = "aa000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください") # "Password is too short (minimum is 6 characters)"
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード(確認用)とパスワードの入力が一致しません") # "Password confirmation doesn't match Password"
      end
      it "passwordが6文字以上でも英字のみでは登録できない" do
        @user.password = "abcdef"
        @user.password_confirmation = "abcdef"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です") # "Password is invalid"
      end
      it "passwordが6文字以上でも数字のみでは登録できない" do
        @user.password = "000000"
        @user.password_confirmation = "000000"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です") # "Password is invalid"
      end
      it "lastname(苗字)が空だと登録できない" do
        @user.lastname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角) 苗字を入力してください") # "Lastname can't be blank"
      end
      it "lastname(苗字)が半角英数字だと登録できない" do
        @user.lastname = 'hankaku'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角) 苗字は全角で入力して下さい") # "Lastname Full-width characters"
      end
      it "firstname(名前)が空だと登録できない" do
        @user.firstname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角) 名前を入力してください") # "Firstname can't be blank"
      end
      it "firstname(名前)が半角英数字だと登録できない" do
        @user.firstname = 'hankaku'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(全角) 名前は全角で入力して下さい") # "Firstname Full-width characters"
      end
      it "lastname_reading(苗字読み)が空だと登録できない" do
        @user.lastname_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角) 苗字を入力してください") # "Lastname reading can't be blank"
      end
      it "lastname_reading(苗字読み)が半角英数字だと登録できない" do
        @user.lastname_reading = 'hankaku'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角) 苗字は全角(カナ)で入力して下さい") # "Lastname reading Full-width katakana characters"
      end
      it "lastname_reading(苗字読み)が全角でもカタカナ以外だと登録できない" do
        @user.lastname_reading = 'ひらがな漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角) 苗字は全角(カナ)で入力して下さい") # "Lastname reading Full-width katakana characters"
      end
      it "firstname_reading(名前読み)が空だと登録できない" do
        @user.firstname_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角) 名前を入力してください") # "Firstname reading can't be blank"
      end
      it "firstname_reading(名前読み)が半角英数字だと登録できない" do
        @user.firstname_reading = 'hankaku'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角) 名前は全角(カナ)で入力して下さい") # "Firstname reading Full-width katakana characters"
      end
      it "firstname_reading(名前読み)が全角でもカタカナ以外だと登録できない" do
        @user.firstname_reading = 'ひらがな漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(全角) 名前は全角(カナ)で入力して下さい") # "Firstname reading Full-width katakana characters"
      end
      it "birth_date(誕生日)が空だと登録できない" do
        @user.birth_date = ''
        @user.valid?
        binding.pry
        expect(@user.errors.full_messages).to include("誕生日を入力してください") # "Birth date can't be blank"
      end
    end
  end
end

# bundle exec rspec spec/models/user_spec.rb