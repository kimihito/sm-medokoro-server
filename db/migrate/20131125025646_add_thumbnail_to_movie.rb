class AddThumbnailToMovie < ActiveRecord::Migration
  def change
    add_column :movies, :thubmnail, :string
  end
end
