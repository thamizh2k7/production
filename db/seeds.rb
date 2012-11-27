# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
g = General.create(:welcome_mail_subject=>"Dear Admin, This is your email")
User.create(:email => "admin@admin.com", :password => "admin123", :name => "ADMIN", :is_admin => true)

# books
c1 = Category.create(:name => "Sports")
c2 = Category.create(:name => "Autobiography")
c3 = Category.create(:name => "Others")

p1 = Publisher.create(:name => "Penguin", :rental => 75)
p2 = Publisher.create(:name => "Wrox", :rental => 70)

# c2.books.create(:name => "vivek", :description => "this is an autobiography", :isbn10 => "123ad123", :author => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher_id => p1.id, :published => "2009", :pages => 320, :price => 340, :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
# c3.books.create(:name => "spiritual", :description => "god", :isbn10 => "1234343", :author => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher_id => p1.id, :published => "2011/11", :pages => 320, :price => 340, :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
# c1.books.create(:name => "golf", :description => "football is a nice game", :isbn10 => "123bh123", :author => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher_id => p2.id, :published => "2009/11/30", :pages => 320, :price => 340, :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
# c1.books.create(:name => "cricket", :description => "pakistan india t20", :isbn10 => "123bh123", :author => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher_id => p2.id, :published => "2009", :pages => 320, :price => 340, :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")
# c1.books.create(:name => "sachin tendulkar", :description => "god of cricket", :isbn10 => "123bh123", :author => "abc", :isbn13 => "12312321312", :binding =>"Hardcover", :publisher_id => p1.id, :published => "2009", :pages => 320, :price => 340, :strengths => "this is a sample strengths", :weaknesses => "this is sample weaknesses")

# general

# g.general_images.create(:image_url => "http://www.doubledeclutch.com/wp-content/uploads/2011/10/10-porsche-posters-sm.jpg")
# g.general_images.create(:image_url => "http://fc09.deviantart.net/fs71/i/2012/209/b/d/books_and_magazines_design_linspire_solutions_by_linspiresolutions-d5905sx.jpg")
# g.general_images.create(:image_url => "http://cdn.shopify.com/s/files/1/0007/3442/files/New_Year_New_Diary_-_Greens.jpg?1290632676")
# g.general_images.create(:image_url => "http://www.pod-creative.com/_resources/images/projects/news/news_145_morrison_street_2.jpg")
# g.general_images.create(:image_url => "http://wildflowersphotos.com/blog/wp-content/uploads/2012/02/proutyBLOG1.jpg")
# g.general_images.create(:image_url => "http://fc02.deviantart.net/fs70/i/2012/103/9/2/bird_brain_books_1_3_by_rynnay-d4w2ae3.jpg")

# colleges
College.create(:name => "IIM")
College.create(:name => "VIT")

Stream.create(:name => "Mechanical")
Stream.create(:name => "Electrical")
Stream.create(:name => "Computer")
Stream.create(:name => "Biotech")

Semester.create(:name => "1")
Semester.create(:name => "2")
Semester.create(:name => "3")

# resources
r = Resource.create(:name => "internships", :link => "internships")
r.create_image(:image_url => "http://xiarch.com/testing/wp-content/uploads/2012/07/internship.jpg")


# companies for internships
c = Company.create(:name => "something", :offer_position => "developer", :offer_stipend => 20000)
c.create_image(:image_url => "http://polarisleb.com/en/images/stories/company/TheCompany_office_2col.jpg")

# sms for signup and order
Sms.create(:sms_type=>"signup",:content=>"Thank you for registering with us")
Sms.create(:sms_type=>"order",:content=>"Thank you for ordering with us")