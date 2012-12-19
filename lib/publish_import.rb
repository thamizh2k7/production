require 'csv'

csvfile = File.read("tmp/x.csv")
# loop in book objects
# remove images
# get new image from csv
# upload image

CSV.parse(csvfile) do |row|

	isbn = row[0]
	book = Book.where(:isbn13 => isbn).first
	if book
		puts "inside #{book.id}"
		book.images.all.each {|a| a.destroy}
		puts "destroyed images of #{book.id}"
		book.images.create(:image_url => row[1])
		puts row[1]
		puts " ---------------- "
	end
 #  if row[26] !="" && row[26]!="0" && row[26]!=" - "
	# publisher = Publisher.where(:name=>row[26]).first
	# book = Book.where(:isbn13 => row[7]).first
	# if publisher
	# puts "updating success" if book.update_attributes(:publisher_id => publisher.id)
	# else
	# puts "No publisher with name #{row[26]}"
	# end
 #  end
end