class CreateSuiteType < ActiveRecord::Migration[5.1]
  def change
    create_table :suite_types, primary_key: :suite_type_id do |t|
      t.string :type
      t.timestamps
    end
  end
end
