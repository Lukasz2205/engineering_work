# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
user1 = User.create(email: 'example@example.com', password: '123456', role: 'admin', profile: Profile.create(name: 'Example user1'))
user2 = User.create(email: 'example2@example.com', password: '123456', role: 'admin', profile: Profile.create(name: 'Example user2'))

profile1 = user1.profile
profile2 = user2.profile

10.times do
  n = 0
  profile1.posts.create(description: "Post utworzony testowo #{n += 1}")
  profile2.posts.create(description: "Post utworzony testowo #{n += 3}")
end
