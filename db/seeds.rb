User.create!(name: 'Admin User',
             email: 'example@email.com',
             password: 'password',
             password_confirmation: 'password',
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.com"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
users = User.order(:created_at).take(6)
50.times do |n|
  title = "title #{n}"
  description = Faker::Lorem.sentence(5)
  last_excercise = n.days.ago
  users.each { |user| user.lessons.create!(title: title, description: description, last_excercise: last_excercise) }
end