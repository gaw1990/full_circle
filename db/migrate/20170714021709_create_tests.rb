class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests, primary_key: :test_id do |t|
      t.string :class_name
      t.string :test_name
      t.string :file_name
      t.timestamps
    end
  end
end
