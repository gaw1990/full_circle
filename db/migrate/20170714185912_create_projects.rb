class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects, primary_key: :project_id do |t|
      t.string :name
      t.timestamps
    end
  end
end
