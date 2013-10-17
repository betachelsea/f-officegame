class BoardsController < ApplicationController

    def index
        @boards = Board.order("id")
        respond_to do |format|
            format.html
            format.json { render :json => @boards }
        end
    end

    def show
        @board = Board.find(params[:id])
        respond_to do |format|
            format.html
            format.json { render :json => @board }
        end
    end

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

    def update
        @board = Board.find(params[:id])
        board_data = ActiveSupport::JSON.decode(@board.state)
        board_data[params[:x].to_i][params[:y].to_i] = 1
        @board.assign_attributes(state: board_data.to_json)
        if @board.save
            render :json => @board
        end
    end

end
