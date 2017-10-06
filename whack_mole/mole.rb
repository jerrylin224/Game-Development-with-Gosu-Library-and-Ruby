require 'gosu'

class WhackaMole < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = "Whack a Mole"
    @image = Gosu::Image.new('images/mole.png')
    @x = 200
    @y = 200
    @width = 100
    @height = 75
    @velocity_x = 5
    @velocity_y = 5
    @visible = 0
    @hammer = Gosu::Image.new('images/hammer.png')
  end


  def draw
    if @visible > 0
      @image.draw(@x - @width / 2, @y - @height / 2, 1)
    end

    @hammer.draw(mouse_x - 25, mouse_y - 39, 1)
  end

  def update
    @x += @velocity_x
    @y += @velocity_y
    @velocity_x *= -1 if @x + @width / 2 > 800 || @x - @width / 2 < 0
    @velocity_y *= -1 if @y + @height / 2 > 600 || @y - @height / 2 < 0
    @visible -= 1
    @visible = 30 if @visible < -10 && rand < 0.01
  end
end

window = WhackaMole.new
window.show
