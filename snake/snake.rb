require 'gosu'

class Apple
  attr_reader :pos_x, :pos_y

  def initialize(game)
    @game = game
    @pos_x = (rand * 800).round
    @pos_y = (rand * 600).round
    @c = Gosu::Color::RED
  end

  def draw
    @game.draw_quad(@pos_x, @pos_y, @c, @pos_x + 10, @pos_y, @c, @pos_x + 10, @pos_y + 10, @c, @pos_x, @pos_y + 10, @c)
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
    @apple = Apple.new(self)
    @visible = 1
  end

  def draw
    c = Gosu::Color::GREEN
    draw_quad(@x, @y, c, @x + 10, @y, c, @x + 10, @y + 10, c, @x, @y + 10, c) if @visible > 0
    @apple.draw
  end

  def update
    @position = [@x += @x_direction, @y += @y_direction]
    collect_apple
  end

  def collect_apple
    if Gosu.distance(@x, @y, @apple.pos_x, @apple.pos_y) < 10
      @apple = Apple.new(self)
    end
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

    if id == Gosu::KB_ESCAPE
      close
    end
  end
end

game = Game.new
game.show

