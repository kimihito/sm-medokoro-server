class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :url
      t.string :provider

      t.timestamps
    end
  end
end
