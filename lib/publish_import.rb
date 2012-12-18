require 'csv'

csvfile = File.read("tmp/x.csv")
CSV.parse(csvfile) do |row|
  if row[26] !="" && row[26]!="0" && row[26]!=" - "
	publisher = Publisher.where(:name=>row[26]).first
	book = Book.where(:isbn13 => row[7]).first
	if publisher
	puts "updating success" if book.update_attributes(:publisher_id => publisher.id)
	else
	puts "No publisher with name #{row[26]}"
	end
  end
end

