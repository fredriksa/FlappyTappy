class GameObject
  def update_move
    @x -= 5
  end
end

class Pipe < GameObject
  WIDTH = 101.25
  HEIGHT = 399
  
  attr_writer :scored
  attr_reader :left, :right, :top, :bottom, :scored, :x

  def initialize(window, x, y, angle = 0)
  	@angle = angle
  	@x, @y = x, y
    @left, @right, @top, @bottom = 0, 0, 0, 0
    @scored = false

  	@image = Gosu::Image.new(window, "assets/pipe_scaled.png", false)
  end

  def update
    update_move
    @left, @right, @top, @bottom = @x - (WIDTH/2), @x + (WIDTH/2) - 25, @y - (HEIGHT/2) - 22, @y + (HEIGHT/2) - 25
  end

  def draw
  	@image.draw_rot(@x, @y, ZOrder::Object_background2, @angle)
  end

  def out_of_screen?
    if @x + WIDTH < 0
      return true
    end

    return false
  end
end