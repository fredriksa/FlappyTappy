class Ground
  WIDTH = 674
  HEIGHT = 112

  attr_reader :left, :right, :top, :bottom

  def initialize(window)
  	@x, @y = 0, 396

    @top_x = @x
    @top_second_x = @x + WIDTH

  	@image_body = Gosu::Image.new(window, "assets/ground_bottom.png", false)
    @image_top = Gosu::Image.new(window, "assets/ground_top.png", false)
  	@left, @right, @top, @bottom = @x - (WIDTH/2), @x + (WIDTH/2), @y - (HEIGHT/2) + 31, @y + (HEIGHT/2)
  end

  def update
    if @top_x < 0
      @draw_second_top = true
      @top_second_x -= 5
    end

    if @top_x < 0 - WIDTH
      @top_x = 0
    end

    if @top_second_x < 0 - WIDTH
      @top_second_x = 0
    end

    @top_x -= 5
  end

  def draw
    if @draw_second_top == true
      @image_top.draw(@top_x+WIDTH, @y-28, ZOrder::Object_foreground)
    end

    @image_top.draw(@top_x, @y-28, ZOrder::Object_foreground)
  	@image_body.draw(@x, @y, ZOrder::Object_foreground)
  end
end