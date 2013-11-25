class RenameThumbnailColumn < ActiveRecord::Migration
  def change
    rename_column :movies, :thubmnail, :thumbnail
  end
end
