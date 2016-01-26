class CreateGuitars < ActiveRecord::Migration
  def change
    create_table :guitars do |t|
              t.string :brand
              t.string :model
              t.string :serial_num
              t.string :month
              t.string :year
              t.text :description
              t.datetime :published_at

              t.timestamps null: false
    end
  end
end
