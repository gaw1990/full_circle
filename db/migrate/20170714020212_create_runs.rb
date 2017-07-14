class CreateRuns < ActiveRecord::Migration[5.1]
  def change
    create_table :runs, primary_key: :run_id do |t|
      t.belongs_to :suite_type
      t.belongs_to :application
      t.datetime :run_at
      t.string :seed
      t.decimal :duration, precision: 15, scale: 6
      t.timestamps
    end
  end
end
