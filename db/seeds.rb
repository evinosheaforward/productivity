User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
					   admin: true,
						 activated: true,
						 activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
50.times do |n|
  name = Faker::Lorem.sentence(1)
	timeWorking = 50.0
	timeProductive = timeWorking * (n / 50.0)
	date = (50-n).days.ago
  users.each { |user| user.accomplishments.create!(
			name: name,
			timeWorking: timeWorking,
			timeProductive: timeProductive,
			date: date) }
end
