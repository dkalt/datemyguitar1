class RenameBrand < ActiveRecord::Migration

  def change

    rename_column :guitars, :brand, :make

  end
end
