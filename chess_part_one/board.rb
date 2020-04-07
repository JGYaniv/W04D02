require_relative 'piece'

class Board
    def initialize
        @board = Array.new(8){Array.new(8)}
    end

    def add_piece(piece, pos) #class instance of piece & pos array
        piece ||= Piece.new(pos)
        if valid_pos?(pos)
            @board[pos.first][pos.last] = piece
        end
    end

    def valid_pos?(pos) #checks for empty piece on the board
        pos.is_a?(Array) &&
        pos.length == 2 &&
        pos.all? {|el| el.is_a?(Integer)} &&
        pos.first >= 0 &&
        pos.first < 8 &&
        pos.last >= 0 &&
        pos.last < 8
    end

    def move_piece(start_pos, end_pos, color=nil) # move_piece("pasta",nil)
        raise "invalid end position" unless valid_pos?(end_pos)
        raise "invalid start position" unless valid_pos?(start_pos)

        if self[start_pos]
            piece = self[start_pos]
            self[end_pos] = piece #add new pos to the piece
            self[start_pos] = nil
        else
            raise "no piece at start pos"
        end
    end

    def [](pos)
        x, y = pos
        @board[x][y]
    end

    def []=(pos, val)
        x, y = pos
        @board[x][y] = val
    end
end