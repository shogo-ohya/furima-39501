require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
   

  end



  describe "ユーザー新規登録" do
    context '新規登録できる場合' do
      it "nickname、email、password、password_confirmation、first_name、last_name、first_name_kana、last_name_kana、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context "新規登録できない場合" do
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it "重複したメールアドレスは登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "メールアドレスに@を含まない場合は登録できない" do
        @user.email = "testexample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it "英字のみのパスワードでは登録できない" do
        @user.password = "password"
        @user.password_confirmation = "password"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英数字混合で入力してください")
      end
      it "数字のみのパスワードでは登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英数字混合で入力してください")
      end
      it "全角文字を含むパスワードでは登録できない" do
        @user.password = "パスワードtest123"
        @user.password_confirmation = "パスワードtest123"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は英数字混合で入力してください")
      end
      it "パスワードが6文字未満では登録できない" do
        @user.password = "abc12"
        @user.password_confirmation = "abc12"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it "last_name_kanaがからでは登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "姓（全角）に半角文字が含まれていると登録できない" do
        @user.last_name = "Smith" # 半角文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name は全角文字で入力してください")
      end

      it "名（全角）に半角文字が含まれていると登録できない" do
        @user.first_name = "John" # 半角文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角文字で入力してください")
      end

      it "姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない" do
        @user.last_name_kana = "山田Yamada123" # カタカナ以外の文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角カタカナのみで入力してください")
      end

      it "名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない" do
        @user.first_name_kana = "太郎Taro123" # カタカナ以外の文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カタカナのみで入力してください")
      end
    end
  end
end
