class AddSerialRange < ActiveRecord::Migration
  def change
    add_column :guitars, :serial_range_start, :string
    add_column :guitars, :serial_range_end, :string

    Guitar.find_each do |guitar|
      guitar.update(serial_range_start: guitar.serial_num, serial_range_end: guitar.serial_num)
    end

    remove_column :guitars, :serial_num
  end
end
