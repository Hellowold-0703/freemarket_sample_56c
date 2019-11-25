FactoryBot.define do
  factory :user do
    family_name {"橋本"}
    first_name {"良平"}
    family_furigana {"はしもと"}
    first_furigana {"りょうへい"}
    birth_year {"1989/07"}
    email {"cccc@yahoo.co.jp"}
    password {"11111111"}
  end
end