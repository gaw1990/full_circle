class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications, primary_key: :application_id do |t|
      t.string :name
      t.timestamps
    end
  end
end
