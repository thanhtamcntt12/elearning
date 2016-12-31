#User
User.create(name: "Doan Thanh Tam", email: "thanhtamcntt12@gmail.com",
  password: "thanhtam",
  password_confirmation: "thanhtam",
  is_admin: true,
  activated: true,
  created_at: Time.zone.now)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create(name: name, email: email, password: password,
    password_confirmation: password,
    activated: true,
    created_at: Time.zone.now)
end
