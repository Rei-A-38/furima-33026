FactoryBot.define do
  factory :user do
    nickname { 'ニックネーム' }
    email                 { Faker::Internet.free_email }
    password              { '1a' + Faker::Internet.password(min_length: 4) }
    password_confirmation { password }
    kanji_sei { '山田' }
    kanji_mei { '花子' }
    katakana_sei { 'ヤマダ' }
    katakana_mei { 'ハナコ' }
    birthday { Faker::Date.between(from: '1930-01-01', to: '2016-12-31') }
  end
end
