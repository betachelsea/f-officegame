class BoardsController < ApplicationController

    def create
        @user = User.find_by_session_id(cookies[:sid])
        board_data = Array.new(8).map{Array.new(8,0)}
        @board = Board.new(
            state: board_data.to_json,
            turn: 1,
            player1: @user.id,
            player2: params[:opponent_id],
            player1_stone_count: 0,
            player2_stone_count: 0
        )
        if @board.save
            render :json => @board
        end
    end

end
