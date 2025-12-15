# db/seeds.rb
require "faker"

puts "Cleaning existing data..."
User.delete_all
Series.delete_all

STATUSES = %i[ongoing completed upcoming].freeze
GENRES   = %i[action romance comedy drama horror fantasy scifi].freeze

# ----- Users -----
puts "Creating users..."

100.times do
  username = Faker::Internet.unique.username(specifier: 5..12)

  User.create!(
    email:          Faker::Internet.unique.email,
    username:       username,
    password:       "password123",
    password_confirmation: "password123",
    phone_number:   Faker::PhoneNumber.cell_phone_in_e164,
    bio:            Faker::Lorem.paragraph(sentence_count: 2),
    role:           [ 0, 1 ].sample,              # 0 user, 1 admin
    email_verified: [ true, false ].sample,
    subscription_id: [ nil, rand(1..5) ].sample,
    password_reset_token: nil,
    password_reset_sent_at: nil,
    otp_code:       nil,
    otp_expires_at: nil
  )
end

puts "Created #{User.count} users."

# ----- Series -----
puts "Creating series..."

100.times do
  base_title_en = Faker::Book.title
  title_ja      = Faker::JapaneseMedia::Naruto.character
  title_hi      = Faker::Lorem.words(number: 2).join(" ")

  release_date = Faker::Date.between(from: 10.years.ago, to: Date.today)
  end_date     = [ nil, Faker::Date.between(from: release_date, to: Date.today) ].sample

  Series.create!(
    title:           base_title_en,
    titles: {
      "en" => base_title_en,
      "ja" => title_ja,
      "hi" => title_hi
    },
    synopsis:        Faker::Lorem.paragraph(sentence_count: 3),
    description:     Faker::Lorem.paragraph(sentence_count: 5),
    status:          STATUSES.sample,
    genre:           GENRES.sample,
    episodes_count:  rand(1..100),
    total_episodes:  rand(1..100),
    seasons_count:   rand(1..5),
    year:            release_date.year,
    release_date:    release_date,
    end_date:        end_date,
    view_count:      rand(1_000..5_000_000)
  )
end

puts "Created #{Series.count} series."
puts "Seeding done."
