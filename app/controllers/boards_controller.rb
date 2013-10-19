class BoardsController < ApplicationController

    def index
        @boards = Board.order("id desc")
        respond_to do |format|
            format.html
            format.json { render :json => @boards, callback: params[:callback] }
        end
    end

    def show
        @board = Board.find(params[:id])
        respond_to do |format|
            format.html
            format.json { render :json => @board, callback: params[:callback] }
        end
    end

    def create
        @user = User.find_by_session_id(cookies[:sid])
        board_data = Array.new(8).map{Array.new(8,0)}
        board_data[4][3] = 1
        board_data[3][4] = 1
        board_data[3][3] = 2
        board_data[4][4] = 2
        @board = Board.new(
            state: board_data.to_json,
            turn: 1,
            player1: @user.id,
            player2: params[:opponent_id],
            player1_stone_count: 0,
            player2_stone_count: 0
        )
        if @board.save
            render :json => @board, callback: params[:callback]
        end
    end

    def update
        @board = Board.find(params[:id])
        board_data = ActiveSupport::JSON.decode(@board.state)
        @user = User.find_by_session_id(cookies[:sid])
        stone = -1
        if (@board.player1 == @user.id)
            stone = 1
        elsif (@board.player2 == @user.id)
            stone = 2
        end
        Board.update_state(board_data, params[:x].to_i, params[:y].to_i, stone)
        @board.assign_attributes(state: board_data.to_json)
        if @board.save
            render :json => @board, callback: params[:callback]
        end
    end

end
