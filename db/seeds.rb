User.destroy_all
5.times do |index|
  User.create!(first_name: Faker::Games::Overwatch.hero,
               last_name: Faker::Games::Overwatch.location,
               email: "user#{index}" + "@yopmail.com",
               description: Faker::Lorem.paragraph_by_chars(number: rand(20..50)))
end

Event.destroy_all
10.times do
  Event.create!(start_date: Faker::Date.between(from: "2021-02-20", to: "2021-09-25"),
                duration: [30, 60, 90, 120, 180, 210].sample,
                title: Faker::Lorem.paragraph_by_chars(number: rand(5..140)),
                description: Faker::Lorem.paragraph_by_chars(number: rand(20..1000)),
                price: rand(1..1000),
                location: Faker::Address.city,
                host: User.all.sample)
end

Attendance.destroy_all
10.times do
  Attendance.create!(user: User.all.sample,
                     event: Event.all.sample)
end
