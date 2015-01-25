User.create!(name:  "Example",
             surname: "User",
             email: "example@wp.org",
             password:              "foobar",
             password_confirmation: "foobar",
             pesel: "93032213997",
             admin:     true,
             activated: true)

99.times do |n|
  name = Faker::Name.name.split(' ')
  email = "example-#{n+1}@wp.org"
  password = "password"
  User.create!(name:  name[0],
               email: email,
               surname: name[1],
               pesel: "93032213997",
               password:              password,
               password_confirmation: password)
end


Genre.create!(name: "Drama")
Genre.create!(name: "Biography")
Genre.create!(name: "History")
Genre.create!(name: "Lifestyle")
Genre.create!(name: "IT")
Genre.create!(name: "Adventure")
Genre.create!(name: "Comedy")
Genre.create!(name: "Interview")

users = User.all
user  = users.first

Book.create!(title: "Drach",
            synopsis: "Tako rzecze Drach",
            amount: 1,
            genre_id: 1,
            author: "Szczepan Twardoch")


99.times do |n|
  author  = Faker::Name.name
  title = "Leonard part #{n+1}"
  Book.create!(title: title,
              synopsis: "Yet another part of Leonard adventures",
              amount: 1,
              genre_id: 2,
              author: author)
end

Copy.create!(book_id: 1, edition: 1, ISBN: "0-19-852663-6", year_of_print: Time.zone.now.year)
Copy.create!(book_id: 1, edition: 1, ISBN: "0-19-852663-6", year_of_print: Time.zone.now.year)