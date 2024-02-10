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
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it "重複したメールアドレスは登録できない" do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Eメールはすでに存在します")
      end
      it "メールアドレスに@を含まない場合は登録できない" do
        @user.email = "testexample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールは不正な値です")
      end
      it "英字のみのパスワードでは登録できない" do
        @user.password = "password"
        @user.password_confirmation = "password"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
      end
      it "数字のみのパスワードでは登録できない" do
        @user.password = "123456"
        @user.password_confirmation = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
      end
      it "全角文字を含むパスワードでは登録できない" do
        @user.password = "パスワードtest123"
        @user.password_confirmation = "パスワードtest123"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは英数字混合で入力してください")
      end
      it "パスワードが6文字未満では登録できない" do
        @user.password = "abc12"
        @user.password_confirmation = "abc12"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください", "パスワード（確認用）とパスワードの入力が一致しません", "パスワードは英数字混合で入力してください")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名を入力してください", "名は全角文字で入力してください")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓を入力してください", "姓は全角文字で入力してください")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名(カナ)を入力してください", "名(カナ)は全角カタカナのみで入力してください")
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓(カナ)を入力してください", "姓(カナ)は全角カタカナのみで入力してください")
      end
      it "birthdayが空だと登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください", "パスワードは英数字混合で入力してください")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129, max_length: 150)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは128文字以内で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end
      it "姓（全角）に半角文字が含まれていると登録できない" do
        @user.last_name = "Smith" # 半角文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("姓は全角文字で入力してください")
      end

      it "名（全角）に半角文字が含まれていると登録できない" do
        @user.first_name = "John" # 半角文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("名は全角文字で入力してください")
      end

      it "姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない" do
        @user.last_name_kana = "山田Yamada123" # カタカナ以外の文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("姓(カナ)は全角カタカナのみで入力してください")
      end

      it "名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない" do
        @user.first_name_kana = "太郎Taro123" # カタカナ以外の文字を含む
        @user.valid?
        expect(@user.errors.full_messages).to include("名(カナ)は全角カタカナのみで入力してください")
      end
    end
  end
end
