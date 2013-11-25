class AddVideoidToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :videoid, :string
  end
end
