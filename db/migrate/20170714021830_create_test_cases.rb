class CreateTestCases < ActiveRecord::Migration[5.1]
  def change
    create_table :test_cases, primary_key: :test_case_id do |t|
      t.belongs_to :build
      t.belongs_to :test
      t.belongs_to :test_case_result
      t.integer :duration_microseconds
      t.string :error_message

      t.timestamps
    end
  end
end
