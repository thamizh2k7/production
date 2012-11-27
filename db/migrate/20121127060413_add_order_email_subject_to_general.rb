class AddOrderEmailSubjectToGeneral < ActiveRecord::Migration
  def change
    add_column :generals, :order_email_subject, :string
    add_column :generals, :order_email_content, :text
  end
end
