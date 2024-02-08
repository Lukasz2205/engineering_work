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
                                              description: Faker::Lorem.sentence(word_count: rand(1..149))))
user2 = User.create(email:    'example2@example.com',
                    password: '123456',
                    role:     'admin',
                    profile:  Profile.create(name:        Faker::Name.name,
                                             description: Faker::Lorem.sentence(word_count: rand(1..149))))
20.times do
  User.create(email:    "#{Faker::Name.first_name}@example.com",
              password: '123456',
              role:     'user',
              profile:  Profile.create(name:        Faker::Name.name,
                                       description: Faker::Lorem.sentence(word_count: rand(1..150))))
end

profile1 = user1.profile
profile2 = user2.profile

profile1.persisted?
profile2.persisted?

10.times do
  profile1.posts.create(description: Faker::Lorem.sentence(word_count: rand(1..500)))
  profile2.posts.create(description: Faker::Lorem.sentence(word_count: rand(1..500)))
end

private_room = Room.create_private_room([profile1, profile2],  "private_#{profile1.id}_#{profile2.id}")
public_room  = profile1.rooms.create(name: 'Publiczny pokój')

10.times do
  private_room.messages.create(profile: profile1, content: Faker::Lorem.sentence(word_count: rand(1..30)))
  private_room.messages.create(profile: profile2, content: Faker::Lorem.sentence(word_count: rand(1..30)))
end

profiles = Profile.where.not(id: profile1).take(10)
20.times do
  public_room.messages.create(profile: profiles[rand(0..9)], content: Faker::Lorem.sentence(word_count: rand(1..30)))
end

profiles.each do |profile|
  profile1.followees << profile
end
profile2.followees << profile1

post = profile1.posts.first
post.likes.create(profile: profile2)
notification = NotificationsService.new(profile2, post).create_like_notification
notification.save
post.comments.create(message: Faker::Lorem.sentence(word_count: rand(1..30)), profile: profile2)
notification2 = NotificationsService.new(profile2, post).create_comment_notification
notification2.save