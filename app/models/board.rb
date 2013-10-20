class Board < ActiveRecord::Base

    class << self
        def update_state(state, x, y, player)
            
            #有効な更新ではないため中止
            return false if (player == -1)
            return false if (state[x][y] != 0)

            #return false if !effective_move(state, x, y, player)
            effective = false
            enemy = player == 1 ? 2 : 1
            (-1..1).each do |x_diff|
                next if (x+x_diff < 0 || 7 < x+x_diff)
                (-1..1).each do |y_diff|
                    next if (y+y_diff < 0 || 7 < y+y_diff)
                    if (enemy == state[x+x_diff][y+y_diff])
                        if (reverse?(state, x+x_diff, x_diff, y+y_diff, y_diff, player, enemy))
                            continuous_reverse(state, x+x_diff, x_diff, y+y_diff, y_diff, player, enemy)
                            #state[x][y]=player
                            effective = true
                        end
                    end
                end
            end
            state[x][y]=player if effective
            effective
            #state[x][y] = player
        end

        def continuous_reverse(state, x, x_diff, y, y_diff, player, enemy)
            if (state[x][y] == enemy)
                state[x][y] = player
                continuous_reverse(state, x+x_diff, x_diff, y+y_diff, y_diff, player, enemy)
            end
        end

        def reverse?(state, x, x_diff, y, y_diff, player, enemy)
            return false if (x < 0 || 7 < x || y < 0 || 7 < y)
            check_stone = state[x][y]

            if (check_stone == player)
                true
            elsif (check_stone == enemy)
                reverse?(state, x+x_diff, x_diff, y+y_diff, y_diff, player, enemy)
            else
                false
            end
        end

        def count_stone(state, count_stone)
            num = 0
            (0..7).each do |x|
                (0..7).each do |y|
                    if (state[x][y] == count_stone)
                        num += 1
                    end
                end
            end
            num
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
