##
# These are all written by Eric Lawler.

# - RSpec adds ./lib to the $LOAD_PATH
require 'bowling'

describe Bowling, "#score" do
  context 'with no strikes or spares' do
    it 'sums the pin count for each throw' do
      bowling = Bowling.new
      10.times { bowling.hit(4) }
      expect(bowling.score).to eq 40
    end
  end
  context 'with only strikes' do
    it 'sums the pin count for each frame' do
      bowling = Bowling.new
      12.times { bowling.hit(10) }
      expect(bowling.score).to eq 300
    end
  end
end
