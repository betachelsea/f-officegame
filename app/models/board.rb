class Board < ActiveRecord::Base

    class << self
        def update_state(state, x, y, player)
            if (player == -1)
                return false #有効な更新ではないため中止
            end
            state[x][y] = player
            true #更新有効
        end
    end

end
