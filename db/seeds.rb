# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(:email => "admin@admin.com", :password => "admin123", :name => "ADMIN", :is_admin => true)

# books
c1 = Category.create(:name => "Sports")
c2 = Category.create(:name => "Autobiography")
c3 = Category.create(:name => "Others")

c2.books.create(:name => "vivek", :description => "this is an autobiography", :isbn10 => "123ad123", :auther => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher => "penguin books", :published => Date.parse("23-01-2009"), :pages => 320, :price => 340, :age => "2 months old", :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
c3.books.create(:name => "spiritual", :description => "god", :isbn10 => "1234343", :auther => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher => "penguin books", :published => Date.parse("23-01-2009"), :pages => 320, :price => 340, :age => "2 months old", :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
c1.books.create(:name => "golf", :description => "football is a nice game", :isbn10 => "123bh123", :auther => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher => "penguin books", :published => Date.parse("23-01-2009"), :pages => 320, :price => 340, :age => "2 months old", :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
c1.books.create(:name => "cricket", :description => "pakistan india t20", :isbn10 => "123bh123", :auther => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher => "penguin books", :published => Date.parse("23-01-2009"), :pages => 320, :price => 340, :age => "2 months old", :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
c1.books.create(:name => "sachin tendulkar", :description => "god of cricket", :isbn10 => "123bh123", :auther => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher => "penguin books", :published => Date.parse("23-01-2009"), :pages => 320, :price => 340, :age => "2 months old", :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")