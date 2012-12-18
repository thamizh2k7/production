require 'csv'

csvfile = File.read("tmp/x.csv")
CSV.parse(csvfile) do |row|
  if row[7] !="" && row[7]!="0" && row[7]!=" - "
      publisher = Publisher.where(:name=>row[7]).first
    if publisher.nil?
      publisher = Publisher.create(:name=>row[7])
    end
  end
  File.open("tmp/linecount.txt",'a') do |file|
    file.puts row[4]
    file.puts e.message
    file.puts "-------------------------------------"
  end
end
