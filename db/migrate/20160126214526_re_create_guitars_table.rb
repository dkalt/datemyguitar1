class ReCreateGuitarsTable < ActiveRecord::Migration
  def change
    unless Rails.env.development?
      drop_table :guitars rescue nil
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
end
