class BoardsController < ApplicationController

    def create
        @user = User.find_by_session_id(cookies[:sid])
        @board = Board.new(
            state: "{'set'}",
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
