class CreateCores < ActiveRecord::Migration
  def change
    create_table :cores, options: 'ENGINE=InnoDB DEFAULT CHARSET=utf8'  do |t|
      t.string :group_id
      t.string :item_id
      t.string :item_value
      t.timestamps null: false
    end
  end
end
