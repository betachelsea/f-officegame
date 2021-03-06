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
        @user = User.find_by_session_id(params[:sid])
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
            player1_stone_count: 2,
            player2_stone_count: 2
        )
        if @board.save
            render :json => @board, callback: params[:callback]
        end
    end

    def update
        @board = Board.find(params[:id])
        board_data = ActiveSupport::JSON.decode(@board.state)
        @user = User.find_by_session_id(params[:sid])
        stone = -1
        if (@board.player1 == @user.id)
            stone = 1
        elsif (@board.player2 == @user.id)
            stone = 2
        end

        if (@board.turn != stone)
            stone = -1
        end

        effective = Board.update_state(board_data, params[:x].to_i, params[:y].to_i, stone)
        next_turn = @board.turn == 1 ? 2 : 1
        if (!effective)
            next_turn = @board.turn
        end
        stone_1 = Board.count_stone(board_data, 1)
        stone_2 = Board.count_stone(board_data, 2)
        winner = nil
        if (stone_1 + stone_2 == 8*8)
            winner = stone_1 > stone_2 ? 1 : 2
        end
        @board.assign_attributes(state: board_data.to_json,
                                 turn: next_turn,
                                 player1_stone_count: stone_1,
                                 player2_stone_count: stone_2,
                                 winner: winner)
        if @board.save
            render :json => @board, callback: params[:callback]
        end
    end

    def pass
        @board = Board.find(params[:id])
        @user = User.find_by_session_id(params[:sid])

        #パスが正当かどうか確認後実施
        turn_user_id = @board.turn == 1 ? @board.player1 : @board.player2
        if (turn_user_id == @user.id)
            @board.turn = @board.turn == 1 ? 2 : 1
        end

        if @board.save
            respond_to do |format|
                format.html { redirect_to :action => "show", :id => @board.id }
                format.json { render :json => @board, callback: params[:callback] }
            end
        end
    end

end
