FactoryBot.define do
  factory :user_purchase do
    prefecture_id               { 2 }
    postal_code                 { '123-4567' }
    city                        { '東京都' }
    house_number                { '1-1' }
    phone_number                { "00000000000" }
    token                       {"tok_abcdefghijk00000000000000000"}
    building_name               {'東京都'}
  end
end
