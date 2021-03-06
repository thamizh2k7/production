require 'open-uri'
require 'digest/sha1'

class RemoteFile < ::Tempfile

  def initialize(path, tmpdir = Dir::tmpdir)
    @original_filename  = File.basename(path)
    @remote_path        = path

    super Digest::SHA1.hexdigest(path), tmpdir
    fetch
  end

  def fetch
    string_io = OpenURI.send(:open, @remote_path)
    self.write string_io.read
    self.rewind
    self
  end

  def original_filename
    @original_filename
  end

  def content_type
    mime = `file --mime -br #{self.path}`.strip
    mime = mime.gsub(/^.*: */,"")
    mime = mime.gsub(/;.*$/,"")
    mime = mime.gsub(/,.*$/,"")
    mime
  end
end
@files = Dir.glob("/var/www/sociorent.com/current/tmp/TMH/*.*")
puts @files
@files.each do |file|
        puts "#{file}"
        tempfile = Tempfile.new(file)
        remote_file = RemoteFile.new(file)
  isbn = File.basename(file).split(".")[0]
  puts "#{isbn}"
  begin
          book=Book.find_by_isbn13(isbn)
                book.images.create(:image=>remote_file)
          puts "=================="
        rescue Exception
                puts "Error: #{isbn}"
                next
        end
end
