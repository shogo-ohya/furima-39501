FactoryBot.define do
  factory :user do
    gimei = Gimei.name
    nickname { Faker::Name.first_name }
    first_name { gimei.first.kanji }
    last_name { gimei.last.hiragana}
    first_name_kana { gimei.first.katakana }
    last_name_kana { gimei.last.katakana }
  # Gimei
  # 直接日本語を記入する
    email { Faker::Internet.email }
    password { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    birthday { Faker::Date.between(from: '1930-01-01', to: '2005-12-31') }
  end

end
