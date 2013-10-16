class BoardsController < ApplicationController

    def create
        @board = Board.new()
    end

end
