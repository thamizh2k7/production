class ChangeBankNameToNameInBanks < ActiveRecord::Migration
  def change
  	rename_column :banks ,:bank_name, :name
  end
end
