require 'gosu'
require 'pry'

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

class Snake
  attr_reader :x, :y, :segments
  attr_accessor :x_direction, :y_direction

  def initialize(game)
    @game = game
    # draw_quad(@x, @y, c, @x + 10, @y, c, @x + 10, @y + 10, c, @x, @y + 10, c)
    @x = 200
    @y = 200
    @x_direction = 3
    @y_direction = 0
    @segments = []
    @head_segment = Segment.new(@x, @y, @game)
    @segments.push(@head_segment)
  end
end

class Segment
  def initialize(x, y, game)
    @game = game
    @x, @y = x, y
    @c = Gosu::Color::GREEN
  end

  def draw
    @game.draw_quad(@x, @y, @c, @x + 10, @y, @c, @x + 10, @y + 10, @c, @x, @y + 10, @c)
  end

  def update
    @position = [@x += @x_direction, @y += @y_direction]
  end
end

class Game < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = "Snake"
    @apple = Apple.new(self)
    @c = Gosu::Color::GREEN
    @snake = Snake.new(self)
    # @segment = Segment.new(@x, @y, @c, self)
  end

  def draw
    # draw_quad(@x, @y, c, @x + 10, @y, c, @x + 10, @y + 10, c, @x, @y + 10, c)
    # binding.pry
    @snake.segments.each do |s|
      s.draw
    end
    @apple.draw
  end

  def update
    # @segment.update
    # @position = [@x += @x_direction, @y += @y_direction]
    # collect_apple
  end

  def collect_apple
    @apple = Apple.new(self) if apple_eaten?
  end

  def apple_eaten?
    if Gosu.distance(@segment.x, @segment.y, @apple.pos_x, @apple.pos_y) < 10
      return true
    end
  end

  def increase_segment
    #if apple_eaten?

  end

  def button_down(id)
    if id == Gosu::KB_RIGHT && @snake.x_direction != -3
      @snake.x_direction = 3
      @snake.y_direction = 0
    end

    if id == Gosu::KB_LEFT && @snake.x_direction != 3
      @snake.x_direction = -3
      @snake.y_direction = 0
    end

    if id == Gosu::KB_DOWN && @snake.y_direction != -3
      @snake.x_direction = 0
      @snake.y_direction = 3
    end

    if id == Gosu::KB_UP && @snake.y_direction !=  3
      @snake.x_direction = 0
      @snake.y_direction = -3
    end

    if id == Gosu::KB_ESCAPE
      close
    end
  end
end

game = Game.new
game.show

