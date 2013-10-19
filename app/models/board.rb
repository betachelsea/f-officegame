class Board < ActiveRecord::Base

    class << self
        def update_state(state, x, y, player)
            state[x][y] = player
            state
        end
    end

end
