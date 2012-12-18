require 'csv'

csvfile = File.read("tmp/x.csv")
CSV.parse(csvfile) do |row|
  if row[38] !="" && row[38]!="0" && row[38]!=" - "
	stream = Stream.find_or_create_by_name(row[38])
	book = Book.where(:isbn13 => row[7]).first
	if stream
		puts "updating success" if book.book_streams.create(:stream_id=>stream.id)
	else
		puts "No stream with name #{row[38]}"
	end
  end
end

