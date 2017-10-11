require 'gosu'
gem 'pry', '= 0.10.3'
require 'pry'
require 'pry-nav'
require 'pry-remote'

class Snake
  attr_reader :x, :y, :segments
  attr_accessor :direction, :ticker

  def initialize(game)
    @game = game
    # draw_quad(@x, @y, c, @x + 10, @y, c, @x + 10, @y + 10, c, @x, @y + 10, c)
    @x = 200
    @y = 200
    @speed = 3
    @direction = "right"
    @segments = []
    @head_segment = Segment.new(@x, @y, @game)
    @segments.push(@head_segment)
    @ticker = 0
  end

  def draw
    @segments.each do |s|
      s.draw
    end
  end

  def update_position
    add_segment
    @segments.shift(1) unless @ticker > 0
  end

  def add_segment
    if @direction == "left"
      x = @head_segment.x - @speed
      y = @head_segment.y
      new_segment = Segment.new(x, y, @game)
    end

    if @direction == "right"
      x = @head_segment.x + @speed
      y = @head_segment.y
      new_segment = Segment.new(x, y, @game)
    end

    if @direction == "up"
      x = @head_segment.x
      y = @head_segment.y - @speed
      new_segment = Segment.new(x, y, @game)
    end

    if @direction == "down"
      x = @head_segment.x
      y = @head_segment.y + @speed
      new_segment = Segment.new(x, y, @game)
    end

    @head_segment = new_segment
    @segments.push(@head_segment)
  end

  def ate_apple?(apple)
    if Gosu.distance(@head_segment.x, @head_segment.y, apple.pos_x, apple.pos_y) < 10
      @ticker += 10
      return true
    end
  end

  def hit_wall?
    if @head_segment.x > 790 || @head_segment.x <  0 || @head_segment.y < 0 || @head_segment.y > 600
      return true
    end
  end

  def hit_self?
    segments = Array.new(@segments)
    if segments.length > 5
      # Remove the head segment from consideration
      segments.pop((5 * @speed))
      segments.each do |s|
        if Gosu::distance(@head_segment.x, @head_segment.y, s.x, s.y) < 1
          return true
        else
          next
        end
      end
      return false
    end
  end
end

class Segment
  attr_reader :x, :y

  def initialize(x, y, game)
    @game = game
    @x, @y = x, y
    @c = Gosu::Color::GREEN
  end

  def draw
    @game.draw_quad(@x, @y, @c, @x + 10, @y, @c, @x + 10, @y + 10, @c, @x, @y + 10, @c)
  end

#  def update
#    @position = [@x += @x_direction, @y += @y_direction]
#  end
end

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
    @apple = Apple.new(self)
    @c = Gosu::Color::GREEN
    @snake = Snake.new(self)
    # @segment = Segment.new(@x, @y, @c, self)
    @font = Gosu::Font.new(30)
    @playing = true
  end

  def draw
    # draw_quad(@x, @y, c, @x + 10, @y, c, @x + 10, @y + 10, c, @x, @y + 10, c)
    # binding.pry
      @snake.draw
      @apple.draw

      @font.draw("Game Over!", 300, 300, 3) unless @playing
  end

  def update
    if @playing
    # @segment.update
    # @position = [@x += @x_direction, @y += @y_direction]
      collect_apple
      @snake.update_position
      @snake.ticker -= 1 if @snake.ticker > 0
      @playing = false if @snake.hit_wall? || @snake.hit_self?
    end
  end

  def collect_apple
    @apple = Apple.new(self) if @snake.ate_apple?(@apple)
  end


  def increase_segment
    #if apple_eaten?

  end

  def button_down(id)
    if id == Gosu::KB_RIGHT && @snake.direction != "right" && @snake.direction != "left"
      @snake.direction = "right"
    end

    if id == Gosu::KB_LEFT && @snake.direction != "left" && @snake.direction != "right"
      @snake.direction = "left"
    end

    if id == Gosu::KB_DOWN && @snake.direction != "down" && @snake.direction != "up"
      @snake.direction = "down"
    end

    if id == Gosu::KB_UP && @snake.direction !=  "up" && @snake.direction != "down"
      @snake.direction = "up"
    end

    if id == Gosu::KB_ESCAPE
      close
    end
  end
end

game = Game.new
game.show

