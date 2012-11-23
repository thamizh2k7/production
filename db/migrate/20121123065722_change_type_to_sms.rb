class ChangeTypeToSms < ActiveRecord::Migration
  def up
  	rename_column :sms, :type, :sms_type 
  end

  def down
  	rename_column :sms, :sms_type, :type
  end
end
