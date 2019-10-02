##
# These are all written by Eric Lawler.

# - RSpec adds ./lib to the $LOAD_PATH
require 'bowling'

describe Bowling do
  before(:each) do
    #prepare a rocket for all of the tests
    @bowling = Bowling.new
  end

  context 'throwing no strikes or spares' do
    it 'calculates the score of knocking down 4 pins, 20 times' do
      20.times { @bowling.hit(4) }
      expect(@bowling.score).to eq 80
    end

    it 'calculates the score of throwing only gutterballs' do
      20.times { @bowling.hit(0) }
      expect(@bowling.score).to eq 0
    end
  end
  context 'throwing only strikes' do
    it 'calculates the score of a perfect game' do
      12.times { @bowling.hit(10) }
      expect(@bowling.score).to eq 300
    end
  end
  context 'throwing only spares' do
    it 'throws strike-spares' do
      10.times do
        @bowling.hit(0)
        @bowling.hit(10)
      end

      # final throw in frame 10
      @bowling.hit(0)
      expect(@bowling.score).to eq 100
    end
    it 'throws 5-pin spares' do
      10.times do
        @bowling.hit(5)
        @bowling.hit(5)
      end

      # final throw in frame 10
      @bowling.hit(5)
      expect(@bowling.score).to eq 150
    end
  end
  context 'throwing how Eric usually bowls' do
    it 'calculates the score for a thoroughly mediocre game' do
      @bowling.hit(7)
      @bowling.hit(2)
      @bowling.hit(10)
      @bowling.hit(4)
      @bowling.hit(3)
      @bowling.hit(8)
      @bowling.hit(2)
      @bowling.hit(7)
      @bowling.hit(0)
      @bowling.hit(0)
      @bowling.hit(9)
      @bowling.hit(8)
      @bowling.hit(0)
      @bowling.hit(10)
      @bowling.hit(7)
      @bowling.hit(1)
      @bowling.hit(6)
      @bowling.hit(4)
      @bowling.hit(8)

      expect(@bowling.score).to eq 118
    end
  end

  context 'visually display score' do
    it 'shows a nifty ASCII bowling scorecard for a perfect game' do
      score_board = <<~HEREDOC
      +--------------------------------------------------------------------------------------------------------------------------------------------------+
      | Bowler             | Frame 1   | Frame 2   | Frame 3   | Frame 4   | Frame 5   | Frame 6   | Frame 7   | Frame 8   | Frame 9   | Frame 10        |
      +--------------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------------+
      | Anonymous          |     |  X  |     |  X  |     |  X  |     |  X  |     |  X  |     |  X  |     |  X  |     |  X  |     |  X  |  X  |  X  |  X  |
      +--------------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------------+
      HEREDOC

      12.times { @bowling.hit(10) }
      expect(@bowling.score_display).to eq score_board
    end
  end
end
