class CreateTestCaseResults < ActiveRecord::Migration[5.1]
  def change
    create_table :test_case_results do |t|
      t.string :result
      t.timestamps
    end
  end
end
