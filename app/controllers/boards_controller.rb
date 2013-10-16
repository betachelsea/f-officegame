class BoardsController < ApplicationController

    def create
        @board = Board.new(
            state: "{'set'}",
            turn: 1,
            player1: 3,
            player2: params[:user_id],
            player1_stone_count: 0,
            player2_stone_count: 0
        )
        if @board.save
            render :json => @board
        end
    end

end
