class AddColumnUserIdTableUrls < ActiveRecord::Migration[6.0]
  def change
    add_reference :urls, :user, index: true
    add_foreign_key :urls, :users
  end
end
