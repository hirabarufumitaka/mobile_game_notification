class AddScrapingToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :scraping, :integer
    add_index :events, :scraping, unique: true
  end
end
