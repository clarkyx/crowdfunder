# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Category.destroy_all
Project.destroy_all
Pledge.destroy_all
Reward.destroy_all
Tag.destroy_all
Message.destroy_all
tom = User.create(name:"tom", email:"what@gmail.com",password_digest:"123")
bob = User.create(name:"bob", email:"what2@gmail.com",password_digest:"123")
cloth = Category.create(title:'cloth')
game = Category.create(title:'game')
food = Category.create(title:'food')
tomsproject = Project.create!(title:"project1", description:"project1", startdate: Time.now, finishdate: Time.now + 2.days, goal: 200, user_id: tom.id, category_id: cloth.id)
bobproject = Project.create!(title:"project2", description:"project2", startdate: Time.now, finishdate: Time.now + 2.days, goal: 200, user_id: bob.id, category_id: cloth.id)
bobprojectTag = Tag.create!(project_id: bobproject.id, title:"swag")
tomsreward = Reward.create!(project_id: tomsproject.id, price: 50)
tomtobobproject = Message.create!(user_id: tom.id, messagetotype: 'project', messagetoid: bobproject.id)
