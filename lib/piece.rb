# frozen_string_literal: true

class Piece
  attr_reader :type, :row
  attr_accessor :under_piece
  
  def initialize(type, under_piece = nil, row = 1)
    @type = type
    @under_piece = under_piece
    @row = row
  end
end
