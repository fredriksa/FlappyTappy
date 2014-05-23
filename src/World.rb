require 'Gosu'

class World

  def initialize(window)
  	@window = window
  	@objects = []
    @font = Gosu::Font.new(window, Gosu::default_font_name, 35)
    @generate_counter = 0

    @soundtrack = Gosu::Sample.new(window, "sfx/theme.ogg")
    @soundtrack_playing = @soundtrack.play(0.75, 1, true)

    @bg = Gosu::Image.new(window, "assets/background.png", false)
  	@ground = Ground.new(window)
    @player = Player.new(window)
  end

  def generate_pipes
  	@generate_counter += 1
    if @generate_counter > 60
      rand_nr = rand(0..Pipe::HEIGHT/1.5)

      @objects << Pipe.new(@window, GameWindow::WIDTH + Pipe::WIDTH + 150, Pipe::HEIGHT*-1 + 490 - (Player::HEIGHT*1.5) - rand_nr)
      @objects << Pipe.new(@window, GameWindow::WIDTH + Pipe::WIDTH + 150, Pipe::HEIGHT*2 - 240 - rand_nr, 180)
      @generate_counter = 0
    end
  end

  def draw_images
    @bg.draw(0, -112, ZOrder::Background)
  end

  def update
    if @player.alive?
      generate_pipes
      collision

      @player.update
      @ground.update

      @score_counter = 0
      @objects.each do |object|
        if object.x < @player.x && object.scored == false && @score_counter == 1
          @player.increase_score(1)
          object.scored = true
          @score_counter = 0
        else
          @score_counter += 1
        end  
      end
    
      @objects.map {|object| object.update}
      @objects.reject! {|object| object.out_of_screen?}
    end
  end

  def draw
    if @player.alive?
      draw_images
      @font.draw("#{@player.score}", 0, 0, ZOrder::GUI)
      @player.draw
      @ground.draw

  	  @objects.each do |object|
        object.draw
  	  end
    else
      @font.draw("YOU HAVE LOST", GameWindow::WIDTH/2, GameWindow::HEIGHT/4, ZOrder::GUI)
      @font.draw("SCORE: #{@player.score}", GameWindow::WIDTH/2, GameWindow::HEIGHT/3, ZOrder::GUI )
    end
  end

  def collision
    if collide?(@ground, @player)
      @player.die  
    end

    @objects.each do |object|
      if collide?(object, @player)
        @player.die
      end
    end
  end

  def handle_input(button)
    if button == "KbSpace"
      @player.jump
    end
  end

  def collide?(object1, object2)
    if object1.left > object2.right or object1.right < object2.left or object1.bottom < object2.top or object1.top > object2.bottom
      return false
    end

    return true
  end

  def stop
    @soundtrack_playing.stop
  end
end