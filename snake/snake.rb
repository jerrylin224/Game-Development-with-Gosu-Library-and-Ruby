require 'gosu'

class Apple
  def initialize(game)
    @game = game
    x = (rand * 800).round
    y = (rand * 600).round
    c = Gosu::Color::GREEN
    @game.draw_quad(x, y, c, x + 10, y, c, x + 10, y + 10, c, x, y + 10, c)
  end
end

class Game < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = "Snake"
    @position = []
    @x = 200
    @y = 200
    @x_direction = 3
    @y_direction = 0
   #  @apple = Apple.new(self)
  end

  def draw
    c = Gosu::Color::GREEN
    draw_quad(@x, @y, c, @x + 10, @y, c, @x + 10, @y + 10, c, @x, @y + 10, c)
  end

  def update
    @position = [@x += @x_direction, @y += @y_direction]
  end


  def button_down(id)
    if id == Gosu::KB_RIGHT && @x_direction != -3
      @x_direction = 3
      @y_direction = 0
    end

    if id == Gosu::KB_LEFT && @x_direction != 3
      @x_direction = -3
      @y_direction = 0
    end

    if id == Gosu::KB_DOWN && @y_direction != -3
      @x_direction = 0
      @y_direction = 3
    end

    if id == Gosu::KB_UP && @y_direction !=  3
      @x_direction = 0
      @y_direction = -3
    end
  end
end

game = Game.new
game.show
