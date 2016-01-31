class CreateMakers < ActiveRecord::Migration
  def change
    create_table :makers do |t|
      t.string      "maker_name"   # Rickenbacker
      t.string      "maker_url"       # www.rickenbacker.com
      t.text   "maker_description"
      t.string    "maker_serial_url"      # url pointing to serial # details
      t.string    "maker_image_url"

      t.timestamps null: false
    end
  end
end
