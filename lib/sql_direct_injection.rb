require 'active_record'

active_rec= ActiveRecord::Base.connection

Ambassador.all.each do |amb|
  begin
    sql="INSERT INTO ambassadors_colleges (ambassador_id,college_id) VALUES ('#{amb.id}','#{amb.college_id}')"
    puts sql
    active_rec.execute(sql)
  rescue
    puts "error"
  end
end
