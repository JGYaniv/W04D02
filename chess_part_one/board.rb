require_relative 'pieces'



class Board

    attr_reader :board
    def initialize
        @sent = NullPiece.instance
        @board = Array.new(8){Array.new(8,@sent)}
        setup
        # debugg_setup
    end

    def setup
        add_black
        add_white
        add_pawn_rows
    end
    def debugg_setup
        p = Pawn.new([5,1],self)
        add_piece(p,[5,1])
        setup
    end

    def add_white 
        row = [
                Rook.new([0,0], self), 
                Knight.new([1,0], self),
                Bishop.new([2,0], self),
                King.new([3,0], self),
                Queen.new([4,0], self),
                Bishop.new([5,0], self),
                Knight.new([6,0], self),
                Rook.new([7,0], self),
            ]

        @board[0] = row
    end

    def add_black
        row = [
            Rook.new([7,0], self,:black),
            Knight.new([7,1], self,:black),
            Bishop.new([7,2], self,:black),
            King.new([7,3], self,:black),
            Queen.new([7,4], self,:black),
            Bishop.new([7,5], self,:black),
            Knight.new([7,6], self,:black),
            Rook.new([7,7], self,:black)
        ]
        
        @board[7] = row
    end

    def add_pawn_rows
        @board.each.with_index do |row,row_idx|
            row.each.with_index do |col, col_idx|
                pos = [row_idx,col_idx]
                if row_idx == 1
                    pawn = Pawn.new(pos,self)
                    self.add_piece(pawn,pos)

                elsif row_idx == 6
                    pawn = Pawn.new(pos,self,:black)
                    self.add_piece(pawn,pos)
                end
            end
        end
    end

    def add_piece(piece, pos) #class instance of piece & pos array
        # piece ||= Piece.new(pos)
        if valid_pos?(pos)
            @board[pos.first][pos.last] = piece
        end
    end

    def valid_pos?(pos) 
        pos.is_a?(Array) &&
        pos.length == 2 &&
        pos.all? {|el| el.is_a?(Integer)} &&
        pos.first >= 0 &&
        pos.first < 8 &&
        pos.last >= 0 &&
        pos.last < 8
    end

    def render 
        @board.each do |row|
            p row.map{|p| p.symbol.to_s}.join(" ")
            puts ""
        end
        true
    end

    def move_piece(start_pos, end_pos, color=nil)
        raise "invalid end position" unless valid_pos?(end_pos)
        raise "invalid start position" unless valid_pos?(start_pos)
        
        
        if self[start_pos]
            piece = self[start_pos]

            unless piece.moves.include?(end_pos)
                puts "illegal move"
                return false
            end

            piece.pos = end_pos
            self[end_pos] = piece #add new pos to the piece
            self[start_pos] = @sent
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

if __FILE__ == $PROGRAM_NAME
    b = Board.new
    b.add_black
    b.add_white
    b.add_pawn_rows
    b.move_piece([1,0],[2,0])
end