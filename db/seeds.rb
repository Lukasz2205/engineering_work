# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
user1 = User.create(email:    'example@example.com',
                    password: '123456',
                    role:     'admin',
                    profile:  Profile.create(name:         Faker::Name.name,
                                              description: Faker::Quote.jack_handey))
user2 = User.create(email:    'example2@example.com',
                    password: '123456',
                    role:     'admin',
                    profile:  Profile.create(name:        Faker::Name.name,
                                             description: Faker::Quote.jack_handey))
20.times do
  User.create(email:    "#{Faker::Name.first_name}@example.com",
              password: '123456',
              role:     'user',
              profile:  Profile.create(name:        Faker::Name.name,
                                       description: Faker::Quote.jack_handey))
end

profile1 = user1.profile
profile2 = user2.profile

10.times do
  profile1.posts.create(description: Faker::Lorem.sentence(word_count: rand(1..500)))
  profile2.posts.create(description: Faker::Lorem.sentence(word_count: rand(1..500)))
end
