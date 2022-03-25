# frozen_string_literal: true

require_relative 'piece'

class Game
  attr_accessor :board, :current_piece

  def initialize
    dummy = Piece.new(0)
    @board = {
      row6: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
      row5: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
      row4: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
      row3: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
      row2: [dummy, dummy, dummy, dummy, dummy, dummy, dummy],
      row1: [dummy, dummy, dummy, dummy, dummy, dummy, dummy]
    }
    @current_piece = nil
    @current_player = 'x'
  end

  def row(number)
    case number
    when 1
      row = board[:row1]
    when 2
      row = board[:row2]
    when 3
      row = board[:row3]
    when 4
      row = board[:row4]
    when 5
      row = board[:row5]
    when 6
      row = board[:row6]
    when 7
      row = board[:row7]
    end
    row
  end

  def play_round
    input = ask_input
    place_in_column(input, @current_player)
    if game_finished?
      display_board
      puts "Player #{@current_player} wins!"
      return
    end
    @current_player = @current_player == 'x' ? 'o' : 'x'
    board_full?
  end

  def game_finished?
    four_in_a_row?(current_piece) || four_in_a_column?(current_piece) || four_in_a_diagonal?
  end

  def four_in_a_diagonal?
    four_in_a_diagonal_bottom_left?(current_piece) || four_in_a_diagonal_bottom_right?(current_piece) ||
    four_in_a_diagonal_top_left?(current_piece) ||
    four_in_a_diagonal_top_right?(current_piece)
  end

  def four_in_a_row?(piece)
    row = []
    four_pieces = piece.type == 'x' ? 'xxxx' : 'oooo'
    i = 0
    until i == 7
      row << row(piece.row)[i].type
      i += 1
    end
    row.join.include?(four_pieces)
  end

  def four_in_a_column?(piece)
    four_pieces = piece.type == 'x' ? 'xxxx' : 'oooo'
    column = []
    until piece.nil?
      column << piece.type
      piece = piece.under_piece
    end
    column.join.include?(four_pieces)
  end

  def four_in_a_diagonal_top_right?(piece)
    four_pieces = piece.type == 'x' ? 'xxxx' : 'oooo'
    diagonal = []
    diagonal << piece.type
    n = piece.row
    j = row(n).index(piece)
    3.times do
      n += 1
      j += 1 unless j.nil?
      if j.between?(0, 6) && n.between?(1, 6)
        diagonal << row(n)[j].type if row(n)[j].is_a? Piece
      end
    end
    diagonal.join == four_pieces
  end

  def four_in_a_diagonal_top_left?(piece)
    four_pieces = piece.type == 'x' ? 'xxxx' : 'oooo'
    diagonal = []
    diagonal << piece.type
    n = piece.row
    j = row(n).index(piece)
    3.times do
      n += 1
      j -= 1 unless j.nil?
      if j.between?(0, 6) && n.between?(1, 6)
        diagonal << row(n)[j].type if row(n)[j].is_a? Piece
      end
    end
    diagonal.join == four_pieces
  end

  def four_in_a_diagonal_bottom_right?(piece)
    four_pieces = piece.type == 'x' ? 'xxxx' : 'oooo'
    diagonal = []
    diagonal << piece.type
    n = piece.row
    j = row(n).index(piece)
    3.times do
      n -= 1
      j += 1 unless j.nil?
      if j.between?(0, 6) && n.between?(1, 6)
        diagonal << row(n)[j].type if row(n)[j].is_a? Piece
      end
    end
    diagonal.join == four_pieces
  end

  def four_in_a_diagonal_bottom_left?(piece)
    four_pieces = piece.type == 'x' ? 'xxxx' : 'oooo'
    diagonal = []
    diagonal << piece.type
    n = piece.row
    j = row(n).index(piece)
    3.times do
      n -= 1
      j -= 1 unless j.nil?
      if j.between?(0, 6) && n.between?(1, 6)
        diagonal << row(n)[j].type if row(n)[j].is_a? Piece
      end
    end
    diagonal.join == four_pieces
  end

  def ask_input
    display_board
    puts "It's the #{@current_player} player turn"
    puts 'Choose a column (0, 6)'
    input = gets.chomp
    input = convert_to_i(input)
    if input.nil? || input > 6 || input.negative?
      puts 'Wrong input!'
      play_round
    end
    input
  end

  def place_in_column(input_column, player)
    i = 1
    until row(i)[input_column].type.is_a? Integer
      i += 1
      if i > 6
        puts 'Column full! Choose another'
        return play_round
      end
    end
    row = row(i)
    if i > 1
      row_under = row(i - 1)
      row[input_column] = Piece.new(player, row_under[input_column], i)
    else
      row[input_column] = Piece.new(player)
    end
    @current_piece = row[input_column]
  end

  def board_full?
    i = 1
    until i == 7
      return play_round unless row(i).all? { |piece| piece.type != 0 }

      i += 1
    end
    puts 'Draw!'
    display_board
  end

  private

  def convert_to_i(str)
    begin
      Integer(str)
    rescue ArgumentError
      nil
    end
  end

  def display_board
    print " #{row(6)[0].type} | #{row(6)[1].type} | #{row(6)[2].type} | #{row(6)[3].type} | #{row(6)[4].type} | #{row(6)[5].type} | #{row(6)[6].type}\n"
    print " #{row(5)[0].type} | #{row(5)[1].type} | #{row(5)[2].type} | #{row(5)[3].type} | #{row(5)[4].type} | #{row(5)[5].type} | #{row(5)[6].type}\n"
    print " #{row(4)[0].type} | #{row(4)[1].type} | #{row(4)[2].type} | #{row(4)[3].type} | #{row(4)[4].type} | #{row(4)[5].type} | #{row(4)[6].type}\n"
    print " #{row(3)[0].type} | #{row(3)[1].type} | #{row(3)[2].type} | #{row(3)[3].type} | #{row(3)[4].type} | #{row(3)[5].type} | #{row(3)[6].type}\n"
    print " #{row(2)[0].type} | #{row(2)[1].type} | #{row(2)[2].type} | #{row(2)[3].type} | #{row(2)[4].type} | #{row(2)[5].type} | #{row(2)[6].type}\n"
    print " #{row(1)[0].type} | #{row(1)[1].type} | #{row(1)[2].type} | #{row(1)[3].type} | #{row(1)[4].type} | #{row(1)[5].type} | #{row(1)[6].type}\n"
  end
end
