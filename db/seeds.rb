# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  Actor.create!(name: 'Tom Cruise', biography: 'Tom Cruise is an American actor and filmmaker. Cruise has been nominated for three Academy Awards and has won three Golden Globe Awards. He started his career at age 19 in the 1981 film Endless Love', gender: 'Male')

  Actor.create!(name: 'Johnny Depp', biography: 'John Christopher "Johnny" Depp II is an American actor, producer, and musician. He has won the Golden Globe Award and Screen Actors Guild Award for Best Actor. ', gender: 'Male')

  Actor.create!(name: 'Russell Crowe', biography: 'Russell Ira Crowe is a New Zealand actor, film producer and musician. Although a New Zealander and New Zealand citizen, he has lived most of his life in Australia and identifies himself as an Australian. ', gender: 'Male')

  Actor.create!(name: 'Brad Pitt', biography: 'William Bradley "Brad" Pitt is an American actor and producer. He has received a Golden Globe Award, a Screen Actors Guild Award, and three Academy Award nominations in acting categories', gender: 'Male')

  Actor.create!(name: 'Angelina Jolie', biography: 'Angelina Jolie Pitt is an American actress, filmmaker, and humanitarian. She has received an Academy Award, two Screen Actors Guild Awards, and three Golden Globe Awards, and has been cited as Hollywood highest-paid actress', gender: 'Female')

  Actor.create!(name: 'Leonardo DiCaprio', biography: 'Leonardo Wilhelm DiCaprio is an American actor and film producer. He is an award-winning actor and a three-time Academy Award® nominee. ', gender: 'Male')

  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
