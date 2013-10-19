class Board < ActiveRecord::Base

    class << self
        def update_state(state, x, y, player)
            
            #有効な更新ではないため中止
            return false if (player == -1)
            return false if !effective_move(state, x, y, player)
            
            #ひっくり返せる石があった場合ひっくり返す処理を実施
            
            state[x][y] = player
            true #更新有効
        end

        def effective_move(state, x, y, player)
            enemy = player == 1 ? 2 : 1
            (-1..1).each do |x_diff|
                next if (x+x_diff < 0 || 7 < x+x_diff)
                (-1..1).each do |y_diff|
                    next if (y+y_diff < 0 || 7 < y+y_diff)

                    if (enemy == state[x+x_diff][y+y_diff])
                        return true
                    end
                end
            end
            false #無効な一手（周囲のセルが反転対象外
        end
    end

end
