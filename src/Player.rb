class Player 
  WIDTH = 50
  HEIGHT = 36

  attr_reader :left, :right, :top, :bottom, :score, :alive, :x

  def initialize(window)
    @angle = 0
  	@x, @y = 200, 0 + HEIGHT
    @velocity_x, @velocity_y = 0, 0
    @left, @right, @top, @bottom = 0, 0, 0, 0
    
    @sample_die = Gosu::Sample.new(window, "./sfx/hurt.wav")
    @alive = true
    @score = 0

    @image = Gosu::Image.new(window, "assets/player.png", false)
  end
  
  def draw
  	@image.draw(@x, @y, ZOrder::Player)
  end

  def update
    @velocity_y -= Gosu::offset_y(0, 0.45)
    @left, @right, @top, @bottom = @x - (WIDTH/2), @x + (WIDTH/2), @y - (HEIGHT/2), @y + (HEIGHT/2)
    move
  end
  
  def accelerate
    @velocity_x += Gosu::offset_x(@angle, 0.5)
    @velocity_y += Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @velocity_x
    @y += @velocity_y

    @x %= GameWindow::WIDTH
    @y %= GameWindow::HEIGHT

    @velocity_x *= 0.95
    @velocity_y *= 0.95
  end

  def jump
    @velocity_y += Gosu::offset_y(0, 12.5)
  end
  
  def alive?
    return @alive
  end

  def die
    @alive = false
    @sample_die.play
  end

  def increase_score(score)
    @score += score
    @score.round
  end
end