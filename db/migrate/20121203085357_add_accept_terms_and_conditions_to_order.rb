class AddAcceptTermsAndConditionsToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :accept_terms_of_use, :boolean
  end
end
