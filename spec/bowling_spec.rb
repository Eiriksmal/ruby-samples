##
# These are all written by Eric Lawler.

# - RSpec adds ./lib to the $LOAD_PATH
require 'bowling'

describe Bowling, "#score" do
  context 'with only gutterballs' do
    it 'sums the pin count for each throw' do
      bowling = Bowling.new
      20.times { bowling.hit(0) }
      expect(bowling.score).to eq 0
    end
  end
  context 'with no strikes or spares' do
    it 'sums the pin count for each throw' do
      bowling = Bowling.new
      20.times { bowling.hit(4) }
      expect(bowling.score).to eq 80
    end
  end
  context 'with only strikes' do
    it 'sums the pin count for each frame' do
      bowling = Bowling.new
      12.times { bowling.hit(10) }
      expect(bowling.score).to eq 300
    end
  end
  context 'with only spares' do
    it 'throws strike-spares' do
      bowling = Bowling.new
      10.times do
        bowling.hit(0)
        bowling.hit(10)
      end

      # final throw in frame 10
      bowling.hit(0)
      expect(bowling.score).to eq 100
    end
    it 'throws 5-pin spares' do
      bowling = Bowling.new
      10.times do
        bowling.hit(5)
        bowling.hit(5)
      end

      # final throw in frame 10
      bowling.hit(5)
      expect(bowling.score).to eq 150
    end
  end
end
