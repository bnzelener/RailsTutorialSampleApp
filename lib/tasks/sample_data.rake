namespace :db do
	desc "Fill database with sample users"
	task populate: :environment do
		100.times do |n|
			name = "Example User #{n+1}"
			email = "example-#{n+1}@railstutorial.org"
			password = "password"
			User.create!(name: name,
									 email: email,
									 password: password,
									 password_confirmation: password)
		end
	end
end