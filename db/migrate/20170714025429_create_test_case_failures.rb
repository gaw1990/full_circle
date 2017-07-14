class CreateTestCaseFailure < ActiveRecord::Migration[5.1]
  def change
    create_table :test_case_failures, primary_key: :test_case_failure_id do |t|
      t.belongs_to :test_case
      t.string :message
      t.string :error
      t.timestamps
    end
  end
end
