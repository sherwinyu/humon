# jasmine = require('jasmine-node')

describe "A chess board", ->
  beforeEach ->
    @board = new Board

  it "should convert a letter/number position into an array index", ->
    expect(Board.squares["a1"]).toEqual(0)
    expect(Board.squares["b1"]).toEqual(1)
    expect(Board.squares["a2"]).toEqual(16)
    expect(Board.squares["h8"]).toEqual(119)

  it "should know if an array index represents a valid square", ->
    expect(Board.is_valid_square 0).toBeTruthy()
    expect(Board.is_valid_square 7).toBeTruthy()
    expect(Board.is_valid_square 8).toBeFalsy()
    expect(Board.is_valid_square 15).toBeFalsy()
    expect(Board.is_valid_square 119).toBeTruthy()
    expect(Board.is_valid_square 120).toBeFalsy()
    expect(Board.is_valid_square 129).toBeFalsy()
    expect(Board.is_valid_square -1).toBeFalsy()

  it "should start off clear", ->
    for i in [0..127]
      if Board.is_valid_square(i)
        expect(@board.piece_on(i)).toBeNull()

  describe "#place_piece", ->
    it "should place a piece on the board", ->
      piece = jasmine.createSpy("piece")
      @board.place_piece "a1", piece
      expect(@board.piece_on "a1").toEqual(piece)

    it "should set the piece's location to the given square's index", ->
      piece = jasmine.createSpyObj(Piece, ["position"])
      @board.place_piece "b5", piece
      expect(piece.position).toEqual(65)

