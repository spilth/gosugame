require 'gosu'

class GameWindow < Gosu::Window
  SCREEN_WIDTH = 1024
  SCREEN_HEIGHT = 768

  def initialize
    super SCREEN_WIDTH, SCREEN_HEIGHT, false
    self.caption = "Gosu Pong"

    @paddleA = Paddle.new(self, 32)
    @paddleB = Paddle.new(self, 960)
    @ball = Ball.new(self)
  end
  

  def update
    if button_down?(Gosu::KbA)
      @paddleA.moveUp
    end
    if button_down?(Gosu::KbZ)
      @paddleA.moveDown
    end
    if button_down?(Gosu::KbK)
      @paddleB.moveUp
    end
    if button_down?(Gosu::KbM)
      @paddleB.moveDown
    end

    @ball.update

    @ball.checkCollision(@paddleA)
    @ball.checkCollision(@paddleB)
  end
  
  def draw
    @paddleA.draw
    @paddleB.draw
    @ball.draw
  end
end

class Ball
  def initialize(window)
    @window = window
    @ball_image = Gosu::Image.new(@window, "media/ball.png", true)
    @blip_sound = Gosu::Sample.new(@window, "media/blip.wav")
    @blop_sound = Gosu::Sample.new(@window, "media/blop.wav")
    @x = 512
    @y = 384
    @xVelocity = 4
    @yVelocity = 4
  end

  def checkCollision(paddle)
    return if @x > 68 and @x < 892

    if @x > 60 and @x < 68 and @y >= paddle.y and @y <= (paddle.y + 128)
      @xVelocity = -@xVelocity
      @blop_sound.play
    end
    if @x > 960 and @x < 968 and @y >= paddle.y and @y <= (paddle.y + 128)
      @xVelocity = -@xVelocity
      @blop_sound.play
    end
  end

  def update
    @x += @xVelocity
    @y += @yVelocity
    if @x <= 0
      @xVelocity = -@xVelocity
      @blip_sound.play
    end
    if @x >= 1008
      @xVelocity = -@xVelocity
      @blip_sound.play
    end
    if @y <= 0
      @yVelocity = -@yVelocity
      @blip_sound.play
    end
    if @y >= 752
      @yVelocity = -@yVelocity
      @blip_sound.play
    end

  end

  def draw
    @ball_image.draw(@x, @y, 0)
  end
end

class Paddle
  attr_reader :x, :y
  def initialize(window, x)
    @window = window
    @x = x
    @y = 32
    @paddle_image = Gosu::Image.new(@window, "media/paddle.png", true)
  end

  def moveUp
    return if @y <= 0
    @y -=8
  end

  def moveDown
    return if @y >= 640
    @y += 8
  end

  def draw
    @paddle_image.draw(@x, @y, 0)
  end

end

window = GameWindow.new
window.show

