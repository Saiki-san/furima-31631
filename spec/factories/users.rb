FactoryBot.define do
  factory :user do
    nickname {Faker::Name.last_name}
    email    {Faker::Internet.free_email}

    lastname          {"苗字みょうじ"}
    firstname         {"名前なまえ"}
    lastname_reading  {"ミョウジ"}
    firstname_reading {"ナマエ"}

    birth_date{19300101}

    password              {Faker::Internet.password(min_length: 4)+ "1a"} #Fakerではまれに英字のみ、数字のみの場合があるため後ろに"1a"など付け加える！。
    password_confirmation {password}
  end
end