class AddWelcomeMailSubjectToGeneral < ActiveRecord::Migration
  def change
    add_column :generals, :welcome_mail_subject, :string
    add_column :generals, :welcome_mail_content, :text
  end
end
