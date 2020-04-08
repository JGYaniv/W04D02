class Piece
    attr_reader :board , :color, :pos

    def initialize(pos , board, color = :white)
        @board = board #board class instance
        @color = color
        @pos = pos
        @symbol = :p
    end

    def pos=(val)
        @pos = val
    end


end