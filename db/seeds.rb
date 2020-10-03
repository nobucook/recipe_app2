# メインのサンプルユーザー（admin）を1人作成する
User.create!(name:  "Admin User",
             email: "tomo.nobu777+admin@gmail.com",
             password:              "unkotintin",
             password_confirmation: "unkotintin",
             admin: true)

#簡単ログイン用のユーザーを作成する。(開発環境用)
# User.create!(name: "Guest User",
#                    email: "test@example.com",
#                    password: "foobar",
#                   password_confirmation: "foobar")


#Categoryを作成
categories = %w(Main Side Salad Soup Casserole Rice Bread Noodle Pasta/Gratin Chicken Pork Beef Vegitable Seafood Sweets Party Lunch Others)
categories.length.times do |n|
  name = categories[n]
  Category.create!(name: name)
end
  
  # 追加のユーザーをまとめて生成する（開発環境用）
# 99.times do |n|
#   name  = Faker::Name.name
#   email = "example-#{n+1}@railstutorial.org"
#   password = "password"
#   User.create!(name:  name,
#                email: email,
#                password:              password,
#                password_confirmation: password)
# end

#開発環境用
# users = User.order(:created_at).take(6)
# 50.times do
#   title = "Test Test Test"
#   about = "test test test test test test test test test test test test test test test test test test test test test"
#   ingre = "rice"
#   amount = "1cup"
#   how_to = "wash Rice"
#   no = 1
#   users.each { |user| user.recipes.create!(title: title,
#                                             about: about,
#                                           category_ids: [1],
#                                           # image: open("#{Rails.roots}/db/fixtures/image1.jpg"),
#                                           ingredients_attributes: {
#                                             '0': {ingre: ingre, amount: amount}
#                                           },
#                                           instructions_attributes: {
#                                             '0': {no: no, how_to: how_to}
#                                           }
#                                         ) 
#                                         }
# end

#開発環境用
# user = User.first 
# user2 = User.second 
# liker = users[2..10]
# recipes = Recipe.all[2..10]
# recipes2 = Recipe.all[6..15]
# recipes.each{|liked| user.like(liked)}
# recipes2.each{|liked2| user2.like(liked2)}