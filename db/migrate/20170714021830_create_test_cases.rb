class CreateTestCases < ActiveRecord::Migration[5.1]
  def change
    create_table :test_cases, primary_key: :test_case_id do |t|
      t.belongs_to :build
      t.belongs_to :test
      t.decimal :duration, precision: 15, scale: 6
      t.timestamps
    end
  end
end
