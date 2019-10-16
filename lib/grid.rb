require 'matrix'
require 'cell'

class Grid
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
      line_range = [0, line_index - 1].max .. line_index + 1
      column_range = [0, column_index - 1].max .. column_index + 1

      cell.neighbours =
        @grid.minor(line_range, column_range).entries - [cell]
    end
  end

  def next_generation
    @grid.entries.each(&:calculate_next_generation)
    @grid.entries.each(&:next_generation)
    @generation += 1
    @grid
  end

  def inspect
    string = @grid.to_a.map do |line|
      line.map(&:tile).join
    end.join("\n")

    <<~STR
      #<Grid
      #{string}
      >
    STR
  end
end
