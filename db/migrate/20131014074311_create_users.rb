class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :session_id, null:false #セッションID
      t.string :name #ユーザ名（任意）
      t.timestamps
    end
  end
end
