require 'gosu'

require_relative 'src/pipe.rb'
require_relative 'src/player.rb'
require_relative 'src/world.rb'
require_relative 'src/ground.rb'

module ZOrder
  GUI = 1500
  GUI_background = 1450
  Object_foreground = 550
  Player = 500
  Object_background = 450
  Object_background2 = 400
  Background = 300
end

class GameWindow < Gosu::Window
  HEIGHT, WIDTH, FULLSCREEN, NAME = 640, 480, false, "Flappy Tappy - Fractional"

  def initialize
    super HEIGHT, WIDTH, FULLSCREEN
    self.caption = NAME
    @world_list = []
    @world_list << World.new(self)
  end

  def draw
  	@world_list[0].draw
  end

  def update
  	input
  	@world_list[0].update
  end

  def input
    if button_down? Gosu::KbR then
      @world_list[0].stop
      @world_list.delete_at(0)
      @world_list << World.new(self)
    end
  	if button_down? Gosu::KbW then
      @world_list[0].handle_input("KbW")
    end
  end

  def button_up(id)
    case id
    when Gosu::KbSpace
      @world_list[0].handle_input("KbSpace")
    end
  end
end

window = GameWindow.new
window.show