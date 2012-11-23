class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
    	t.string :type
    	t.text :content
      t.timestamps
    end
  end
end
