namespace :db do
	desc "Fill database with sample users"
	task populate: :environment do
		User.create!(name: "Tyler Durden",
								 email: "contact@brennanzelener.com",
								 password: "password",
								 password_confirmation: "password",
								 admin: true)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
									 email: email,
									 password: password,
									 password_confirmation: password)
		end
	end
end