class CreateBuilds < ActiveRecord::Migration[5.1]
  def change
    create_table :builds, primary_key: :build_id do |t|
      t.integer :build_number
      t.belongs_to :suite_type
      t.belongs_to :project
      t.belongs_to :build_status
      t.datetime :run_at
      t.integer :seed
      t.integer :duration_milliseconds

      t.timestamps
    end
  end
end
