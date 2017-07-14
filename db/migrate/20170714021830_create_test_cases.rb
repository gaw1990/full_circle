class CreateTestCases < ActiveRecord::Migration[5.1]
  def change
    create_table :test_cases, primary_key: :test_case_id do |t|
      t.belongs_to :runs
      t.belongs_to :tests
      t.decimal :duration, precision: 15, scale: 6
      t.timestamps
    end
  end
end
