require 'gosu'

class GameWindow < Gosu::Window
  TILE_SIZE = 32
  SCREEN_WIDTH = 1024
  SCREEN_HEIGHT = 768
  TILES_WIDE = SCREEN_WIDTH / TILE_SIZE
  TILES_HIGH = SCREEN_WIDTH / TILE_SIZE

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT, false
    self.caption = "Gosu Tutorial Game"

    @crosshair_image = Gosu::Image.new(self, "media/crosshair.png", true)
    @block_image = Gosu::Image.new(self, "media/block.png", true)
    @level = Level.new(TILES_WIDE, TILES_HIGH, false)
  end
  
  def button_down(id)
    case id
      when Gosu::MsLeft
        x = (mouse_x / TILE_SIZE).floor
        y = (mouse_y / TILE_SIZE).floor
        @level.toggle(x, y)
    end
  end

  def update
    self.caption = "Location: #{(mouse_x / TILE_SIZE).floor},#{(mouse_y / TILE_SIZE).floor}"
  end
  
  def draw
    @level.grid.each_with_index do |row, x|
      row.each_with_index do |col, y|
        if col
          @block_image.draw(x * TILE_SIZE, y * TILE_SIZE, 0)
        end  
      end
    end
    
    @crosshair_image.draw(mouse_x - 8, mouse_y - 8, 0)
  end
end

class Level
  attr_reader :grid

  def initialize(width, height, default)
    @grid = Array.new(width)
    @grid.map! { Array.new(height, false) }
  end

  def toggle(x,y)
    @grid[x][y] = !@grid[x][y] 
  end

end

window = GameWindow.new
window.show

