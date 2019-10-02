require_relative 'frame.rb'

class Bowling
  attr_reader :frames, :throw, :current_frame, :bowler_name

  def initialize(bowler_name = 'Anonymous')
    # Has to be created in a block, or otherwise it creates one Frame with 9 pointers to it!
    @frames = Array.new(9) { Frame.new } + [Frame.new(true)]
    @throw = 1
    @current_frame = @frames.first
    @frame_count = 1
    @bowler_name = bowler_name[0...18]
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

    @frames.each_with_index do |frame, frame_number|
      frame_total = frame.total
      score += frame_total

      # calculate any possible bonus points we earn from throwing a strike or spare
      if frame_total == 10 && frame.throw_count == 1
        # strike!
        score += bonus_points(2, frame_number)
      elsif frame_total == 10 && frame.throw_count > 1
        # spare!
        score += bonus_points(1, frame_number)
      end
    end

    score
  end

  def score_display
    # create an 18-character wide name (space padded)
    name = bowler_name.ljust(18)

    score_board = <<~HEREDOC
      +--------------------------------------------------------------------------------------------------------------------------------------------------+
      | Bowler             | Frame 1   | Frame 2   | Frame 3   | Frame 4   | Frame 5   | Frame 6   | Frame 7   | Frame 8   | Frame 9   | Frame 10        |
      +--------------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------------+
      | #{name} #{graphical_throws}
      +--------------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------------+
    HEREDOC
  end

  private

  ##
  # Calculate how many bonus points a strike or spare earns
  # @param [Integer] throw_count
  # @param [Integer] frame_number
  # @return [Integer]
  def bonus_points(throw_count, frame_number)
    score = 0

    while throw_count > 0
      frame_number += 1
      check_frame = @frames[frame_number]

      if check_frame.nil? || check_frame.throw_count == 0
        return score
      end

      # add extra points, and decrement the throw_count, for each throw in the next frame
      check_frame.throws.compact.each do |throw|
        if throw_count <= 0
          return score
        end

        score += throw
        throw_count -= 1
      end
    end

    score
  end

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

  def graphical_throws
    string = '|'

    @frames.each_with_index do |frame, frame_number|
      frame_total = frame.total

      # calculate any possible bonus points we earn from throwing a strike or spare
      if frame_total == 10 && frame.throw_count == 1
        if frame_number < 10
          string += '     |' + score_symbol(10)
        else
          string += score_symbol(10)
        end
      elsif frame.first_throw + frame.second_throw == 10
        string += score_symbol(frame.first_throw) + '/'.center(5) + '|'
        string += score_symbol(frame.third_throw) if frame.third_throw
      else
        frame.throws.compact.each do |pins|
          string += score_symbol(pins)
        end
      end

      # add an empty third throw for non-strike/spare 10th frames
      if frame_number == 9 && frame.throw_count < 3
        string += '     |'
      end
    end

    string
  end

  def score_symbol(pins)
    case pins
    when 1...10
      symbol = pins.to_s.center(5) + '|'
    when 10
      symbol = 'X'.center(5) + '|'
    else
      symbol = '-'.center(5) + '|'
    end

    symbol
  end
end
