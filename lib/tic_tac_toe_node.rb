require_relative 'tic_tac_toe'
require "byebug"

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    # debugger
    winner = board.winner
    return false if board.over? && winner.nil?
    return true if board.over? && winner != evaluator

    children.all? do |child_node|
      child_node.losing_node?(evaluator)
    end
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children_mover_mark = ((next_mover_mark == :x) ? :o : :x)
    kids = []
    board.rows.each_with_index do |row, row_i|
      row.each_with_index do |square, col_i|
        if square.nil?
          next_board = board.dup
          next_board[[row_i, col_i]] = next_mover_mark
          kids << TicTacToeNode.new(next_board, children_mover_mark, [row_i, col_i])
        end
      end
    end
    kids
  end
end
