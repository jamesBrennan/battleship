RSpec.describe App do
  before do
    @game = App.new
  end

  describe 'initialization' do
    it 'creates a board' do
      expect(@game.board).to be_a_kind_of(Array)
    end
  end

  describe '.print' do
    it 'shows the board' do
      @game.print
    end
  end

  describe '.place_ship' do
    context 'given valid parameters' do
      before do
        @ship = 2
        @location = [0,0]
        @orientation = 'VERTICAL'
      end

      it 'returns true' do
        expect(@game.place_ship(@ship, @location, @orientation)).to be_truthy
      end

      it 'toggles the values on the board to true' do
        @game.place_ship(@ship, @location, @orientation)
        board = @game.board

        #occupied squares
        # board[y][x]
        expect(board[0][0]).to be_truthy
        expect(board[1][0]).to be_truthy

        #empty squares
        expect(board[1][1]).to be_nil
        expect(board[0][2]).to be_nil
      end
    end

    context 'given a piece that would be placed beyond the edge of the board' do
      before do
        @ship = 2
        @location = [9,9]
        @orientation = 'VERTICAL'
      end

      it 'returns false' do
        expect(@game.place_ship(@ship, @location, @orientation)).to be_falsey
      end

      it 'does not modify the board' do
        expect do
          @game.place_ship(@ship, @location, @orientation)
        end.to_not change { @game.board }
      end
    end
  end

  describe '.fire' do

  end
end
