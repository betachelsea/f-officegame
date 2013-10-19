class Board < ActiveRecord::Base

    class << self
        def update_state(state, x, y, player)
            if (player == -1)
                return false #有効な更新ではないため中止
            end
            
            #隣り合うセルに石が存在しない場合は不可
            
            #隣り合うセルに敵石が存在しない場合は不可
            
            #ひっくり返せる石があった場合ひっくり返す処理を実施
            
            state[x][y] = player
            true #更新有効
        end
    end

end
