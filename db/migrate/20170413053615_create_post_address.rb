class CreatePostAddress < ActiveRecord::Migration
  def change
    create_table :post_addresses, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :postcode, limit: 7
      t.string :prefectures, limit: 16
      t.string :address_general, limit: 512
      t.string :address_detail, limit: 512
      t.timestamps null: false
    end
  end
end
