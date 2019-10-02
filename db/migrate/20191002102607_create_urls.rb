class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :short_url
      t.text :long_url
      t.boolean :status

      t.timestamps
    end
  end
end
