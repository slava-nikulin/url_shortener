class CreateUrlPairs < ActiveRecord::Migration[5.1]
  def change
    create_table :url_pairs do |t|
      t.string :original_url
      t.string :short_path
      t.integer :clicks_count, default: 0

      t.timestamps
    end
  end
end
