# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

# 追加のユーザーをまとめて生成する
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.order(:created_at).take(6)
50.times do
  title = "test test test test test"
  about = "test test test test test test test test test test test test test test test test test test test test test"
  users.each { |user| user.recipes.create!(title: title,
                                            about: about) }
end


user = User.first 
user2 = User.second 
liker = users[2..10]
recipes = Recipe.all[2..10]
recipes2 = Recipe.all[6..15]
recipes.each{|liked| user.like(liked)}
recipes2.each{|liked2| user2.like(liked2)}