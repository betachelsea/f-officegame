class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :session_id, null:false #セッションID
      t.timestamps
    end
  end
end
