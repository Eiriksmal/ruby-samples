##
# Frames hold the result of two individual throws
# The final frame can have three throws, depending on whether the first throw was a strike or second throw was a spare
class Frame
  attr_reader :throws, :is_tenth_frame

  def initialize(is_tenth_frame = false)
    @is_tenth_frame = is_tenth_frame.to_bool
    @throws = Array.new(3)
  end

  def throw_count
    # compact removes nils
    @throws.compact.length
  end

  ##
  # Records this throw's number of pins knocked down to the next slot in this frame
  # @param [Integer] score
  def record(score)
    raise ArgumentError, "Invalid score to record!" if score > 10 or score < 0
    raise ArgumentError, "Frame already recorded maximum number of throws!" if throw_count >= 3

    # find first nil score to record how many pins we hit
    @throws[@throws.index(nil)] = score
  end
end
