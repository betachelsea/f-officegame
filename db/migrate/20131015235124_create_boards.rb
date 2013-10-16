class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :state, null:false #盤面状態を文字列として保持?
      t.integer :turn, null:false #1:ユーザ1のターン、2:ユーザ2のターン
      t.integer :player1, null:false #先攻ユーザID
      t.integer :player2, null:false #後攻ユーザID
      t.integer :player1_stone_count, null:false #先攻ユーザの石数
      t.integer :player2_stone_count, null:false #後攻ユーザの石数
      t.integer :winner, null:true #勝者ユーザID
      t.timestamps
    end
  end
end
