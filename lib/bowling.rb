class Bowling
  attr_reader :score, :frames, :throw, :this_frame

  def initialize
    @score = 0
    @frames = []
    @throw = 1
    @this_frame = 0
  end

  def hit(pin_count)
    if pin_count < 10
      @this_frame += pin_count
      @score += pin_count
    else
      if @throw == 1
        strike
      end
    end

    # increment the throws
    @throw += 1

    # reset the frame?
    if @throw > 2
      next_frame
    end

    @score
  end

  def strike
    if @frames.length > 2
      @score += 10 + last_frame
    end
  end

  def next_frame
    @frames.push(@this_frame)
    @throw = 1
  end

  def last_frame
    @frames.last
  end
end
