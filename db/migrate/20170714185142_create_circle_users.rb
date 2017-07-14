class CreateCircleUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :circle_users, primary_key: :circle_user_id do |t|
      t.string :username
      t.timestamps
    end
  end
end
