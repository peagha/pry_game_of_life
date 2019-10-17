require 'matrix'
require 'cell'

class Grid
  attr_reader :generation

  def initialize(string_grid)
    load_grid(string_grid)
    @generation = 0
  end

  def load_grid(string_grid)
    @grid = string_grid.lines.map do |line|
      line.chomp.chars.map do |cell_string|
        Cell.new(cell_string == 'x')
      end
    end

    @grid = Matrix.rows(@grid)

    @grid.each_with_index do |cell, line_index, column_index|
      cell.neighbours =
        @grid.minor(line_index - 1, 3, column_index - 1, 3).entries - [cell]
    end
  end

  def next_generation
    @grid.entries.each(&:calculate_next_generation)
    @grid.entries.each(&:next_generation)
    @generation += 1
    self
  end

  def pretty_string
    @grid.to_a
      .map { |line| line.map(&:tile).join }
      .then { |lines| lines.join("\n") }
  end

  # def inspect
  #   "#<Grid \n#{pretty_string}>"
  # end
end
