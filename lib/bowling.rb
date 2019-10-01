require_relative 'frame.rb'

class Bowling
  attr_reader :frames, :throw, :current_frame

  def initialize
    # Has to be created in a block, or otherwise it creates one Frame with 9 pointers to it!
    @frames = Array.new(9) { Frame.new } + [Frame.new(true)]
    @throw = 1
    @current_frame = @frames[0]
    @frame_count = 1
  end

  def hit(pin_count)
    @current_frame.record(pin_count)

    # reset the frame?
    if reset_frame?(pin_count)
      next_frame
    else
      # increment the throws
      @throw += 1
    end

    score
  end

  def score
    score = 0
    @frames.each do |frame|
      score += frame.throws.compact.sum
    end

    score
  end

  private

  def next_frame
    @frame_count += 1

    if @frame_count <= 10
      @current_frame = @frames[@frame_count - 1]
      @throw = 1
    end
  end

  ##
  # Hide the bowling business logic
  # @param [Integer]
  # @return [Boolean]
  def reset_frame?(pin_count)
    if (@throw == 2 && @frame_count < 10) || (@throw == 3 && @frame_count == 10)
      true
    elsif pin_count == 10 && @frame_count < 10
      # strikes always reset a frame, unless it's the 10th frame, where we can get 3 in a row
      true
    else
      false
    end
  end

end
