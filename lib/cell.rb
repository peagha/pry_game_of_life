class Cell
  attr_writer :neighbours

  def initialize(alive)
    @alive = alive
  end

  def alive?
    @alive
  end

  def calculate_next_generation
    alive_neighbours = @neighbours.count(&:alive?)

    @next_generation_alive =
      if alive?
        case alive_neighbours
        when 0..1 then false
        when 2..3 then true
        when 3..8 then false
        end
      else
        alive_neighbours == 3
      end
  end

  def next_generation
    @alive = @next_generation_alive
  end

  def tile
    alive? ? '⬛️' : '⬜️'
  end

  def inspect
    "#<Cell #{tile}>"
  end
end
