class Piece
    attr_reader :type
    def initialize(pos)
        @type = :piece
        @pos = pos
    end
end