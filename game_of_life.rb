$LOAD_PATH.prepend('lib')

require 'grid'

seed = File.read(ARGV.first).gsub("⬛️", "x").gsub("⬜️", "_")
grid = Grid.new(seed)

loop do
  grid.next_generation
  system('clear')
  puts grid.inspect
  sleep(0.2)
end
