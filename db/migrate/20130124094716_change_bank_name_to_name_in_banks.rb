class ChangeBankNameToNameInBanks < ActiveRecord::Migration
  def change
  	rename_column :banks ,:bank, :name
  end
end
