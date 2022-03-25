# frozen_string_literal: true

# rubocop: disable

require './lib/game.rb'

describe Game do
  describe '#four_in_a_row?' do
    context 'check the row we put the piece in' do
      subject(:game) { described_class.new }
      let(:piece_x) { Piece.new('x') }
      let(:piece_o) { Piece.new('o') }

      it 'returns true if there are four pieces connected' do
        game.board = {
          row1: [piece_x, piece_o, piece_o, piece_o, piece_o, piece_x, piece_x],
          row2: [0, 0, 0, 0, 0, 0, 0],
          row3: [0, 0, 0, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row6: [0, 0, 0, 0, 0, 0, 0]
        }
        expect(game.four_in_a_row?(piece_o)).to be true
        game.four_in_a_row?(piece_o)
      end

      it 'returns false if there aren\'t four pieces connected' do
        game.board = {
          row1: [piece_x, piece_x, piece_o, piece_o, piece_o, piece_x, piece_x],
          row2: [0, 0, 0, 0, 0, 0, 0],
          row3: [0, 0, 0, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row6: [0, 0, 0, 0, 0, 0, 0]
        }
        expect(game.four_in_a_row?(piece_x)).to be false
        game.four_in_a_row?(piece_x)
      end
    end
  end

  describe '#four_in_a_column?' do
    context 'check the column with put the piece in' do
      subject(:game) { described_class.new }
      let(:piece4) { Piece.new('o', piece3) }
      let(:piece3) { Piece.new('o', piece2) }
      let(:piece2) { Piece.new('o', piece1) }
      let(:piece1) { Piece.new('o') }

      it 'returns true if there are four pieces connected' do
        game.board = {
          row1: [0, 0, piece1, 0, 0, 0, 0],
          row2: [0, 0, piece2, 0, 0, 0, 0],
          row3: [0, 0, piece3, 0, 0, 0, 0],
          row4: [0, 0, piece4, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row6: [0, 0, 0, 0, 0, 0, 0]
        }
        expect(game.four_in_a_column?(piece4)).to be true
        game.four_in_a_column?(piece4)
      end

      it 'returns false if there aren\'t four pieces connected' do
        game.board = {
          row1: [0, 0, piece1, 0, 0, 0, 0],
          row2: [0, 0, piece2, 0, 0, 0, 0],
          row3: [0, 0, piece3, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row6: [0, 0, 0, 0, 0, 0, 0]
        }
        expect(game.four_in_a_column?(piece3)).to be false
        game.four_in_a_column?(piece3)
      end
    end
  end

  describe '#four_in_a_diagonal_top_right?' do
    context 'check the four diagonals going top right' do
      subject(:game) { described_class.new }
      let(:piece4) { Piece.new('o', nil, 4) }
      let(:piece3) { Piece.new('o', nil, 3) }
      let(:piece2) { Piece.new('o', nil, 2) }
      let(:piece1) { Piece.new('o') }

      it 'returns true if there are four pieces connected' do
        game.board = {
          row6: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, piece4, 0],
          row3: [0, 0, 0, 0, piece3, 0, 0],
          row2: [0, 0, 0, piece2, 0, 0, 0],
          row1: [0, 0, piece1, 0, 0, 0, 0]
        }
        expect(game.four_in_a_diagonal_top_right?(piece1)).to be true
        game.four_in_a_diagonal_top_right?(piece1)
      end

      it 'returns false if there aren\'t four pieces connected' do
        game.board = {
          row6: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, 0, 0],
          row3: [0, 0, 0, 0, piece3, 0, 0],
          row2: [0, 0, 0, piece2, 0, 0, 0],
          row1: [0, 0, piece1, 0, 0, 0, 0]
        }
        expect(game.four_in_a_diagonal_top_right?(piece1)).to be false
        game.four_in_a_diagonal_top_right?(piece1)
      end
    end
  end

  describe '#four_in_a_diagonal_bottom_left?' do
    context 'check the diagonal going bottom left' do
      subject(:game) { described_class.new }
      let(:piece4) { Piece.new('o', nil, 1) }
      let(:piece3) { Piece.new('o', nil, 2) }
      let(:piece2) { Piece.new('o', nil, 3) }
      let(:piece1) { Piece.new('o', nil, 4) }

      it 'returns true if there are four pieces' do
        game.board = {
          row6: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, piece1, 0],
          row3: [0, 0, 0, 0, piece2, 0, 0],
          row2: [0, 0, 0, piece3, 0, 0, 0],
          row1: [0, 0, piece4, 0, 0, 0, 0]
        }
        expect(game.four_in_a_diagonal_bottom_left?(piece1)).to be true
        game.four_in_a_diagonal_bottom_left?(piece1)
      end
    end

    context 'check the diagonal going bottom left' do
      subject(:game) { described_class.new }
      let(:piece3) { Piece.new('o', nil, 1) }
      let(:piece2) { Piece.new('o', nil, 2) }
      let(:piece1) { Piece.new('o', nil, 3) }
      
      it 'returns false if there aren\'t four pieces' do
        game.board = {
          row6: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, 0, 0],
          row3: [0, 0, 0, 0, piece1, 0, 0],
          row2: [0, 0, 0, piece2, 0, 0, 0],
          row1: [0, 0, piece3, 0, 0, 0, 0]
        }
        expect(game.four_in_a_diagonal_bottom_left?(piece1)).to be false
        game.four_in_a_diagonal_bottom_left?(piece1)
      end
    end
  end

  describe '#insert_piece' do
  #  it is a collection of different methods
  #  one ask for input by the player
  #  one check if the row choosen is free, if not check the upper row until if find one free
  end

  describe '#ask_input' do
    context 'it ask the player to choose the column, and he put the right number' do
      subject(:game) { described_class.new }
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('3')
        allow(game).to receive(:display_board)
      end

      it 'returns the column integer' do
        expect(game.ask_input).to eq(3)
      end
    end

    context 'it ask the player and he put a wrong input once' do
      subject(:game) { described_class.new }

      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('a', '3')
        allow(game).to receive(:display_board)
      end

      it 'gives puts error once' do
        expect(game).to receive(:puts).with('Wrong input!').once
        game.ask_input
      end
    end
  end

  describe '#place_in_column' do
    context 'we receive an input number between 1 and 7 and the board is empty' do
      subject(:game) { described_class.new }
      let(:piece_expected) { Piece.new('o', piece_x) }
      let(:piece_x) { Piece.new('x') }
      let(:piece_o) { Piece.new('o') }
      let(:piece_dummy) { Piece.new(0) }

      it 'place the piece in the chosen column at the right row' do
        game.board = {
          row6: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, piece_dummy, 0, 0, 0, 0],
          row4: [0, 0, piece_x, 0, 0, 0, 0],
          row3: [0, 0, piece_o, 0, 0, 0, 0],
          row2: [0, 0, piece_x, 0, 0, 0, 0],
          row1: [0, 0, piece_o, 0, 0, 0, 0]
        }
        type = piece_expected.type
        under_piece = piece_expected.under_piece
        game.place_in_column(2, 'o')
        expect(game.board[:row5][2].type).to eq(type)
        expect(game.board[:row5][2].under_piece).to eq(under_piece)
      end
    end
  end

  describe '#row' do
    context 'a simple game item is created' do
      subject(:game) { described_class.new }
      let(:dummy) { Piece.new(0) }

      it 'returns the row called with a number' do
        types = []
        row = game.row(1)
        row.each { |piece| types << piece.type }
        expect(types).to eq([0, 0, 0,0, 0, 0, 0])
      end

      it 'returns nil if the number is outside the board' do
        expect(game.row(8)).to eq nil
      end
    end
    context 'a modified game item is created' do
      subject(:game) { described_class.new }
      let(:piece4) { Piece.new('o') }
      let(:piece3) { Piece.new('o') }
      let(:piece2) { Piece.new('o') }
      let(:piece1) { Piece.new('o') }

      it 'returns the right row' do
        game.board = {
          row6: [0, 0, 0, 0, 0, 0, 0],
          row5: [0, 0, 0, 0, 0, 0, 0],
          row4: [0, 0, 0, 0, 0, piece4, 0],
          row3: [0, 0, 0, 0, piece3, 0, 0],
          row2: [0, 0, 0, piece2, 0, 0, 0],
          row1: [0, 0, piece1, 0, 0, 0, 0]
        }
        expect(game.row(4)).to eq([0, 0, 0, 0, 0, piece4, 0])
      end
    end
  end

  describe '#board_full?' do
    context 'the board is full' do
      subject(:game) { described_class.new }
      let(:dummy) { Piece.new('x') }

      before do
        allow(game).to receive(:display_board)
      end

      it 'returns draw' do
        game.board = {
          row6: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
          row5: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
          row4: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
          row3: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
          row2: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
          row1: [dummy, dummy, dummy, dummy, dummy, dummy, dummy]
        }
        expect(game).to receive(:puts).with('Draw!').once
        game.board_full?
      end
    end
  end
end
