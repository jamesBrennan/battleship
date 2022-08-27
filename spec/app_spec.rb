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

      it 'toggles the values on the board to OCCUPIED' do
        @game.place_ship(@ship, @location, @orientation)
        board = @game.board

        #occupied squares
        # board[y][x]
        expect(board[0][0]).to be_a_kind_of(Ship)
        expect(board[1][0]).to be_a_kind_of(Ship)

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

    context 'given a piece that would overlap an occupied square' do
      before do
        #place first ship
        @game.place_ship(2, [0, 0], 'VERTICAL')
      end

      it 'returns false' do
        # try to place secord ship overlapping first
        expect(@game.place_ship(3, [0, 1], 'HORIZONTAL')).to be_falsey
      end

      it 'does not modify the board' do
        expect do
          @game.place_ship(3, [0, 1], 'HORIZONTAL')
        end.to_not change { @game.board }
      end
    end
  end

  describe '.fire' do
    context 'given coordinates for an empty square' do
      it 'returns MISS' do
        expect(@game.fire([0,0])).to eql('MISS')
      end
    end

    context 'given coordinates for an occupied square' do
      before do
        @game.place_ship(2, [0, 0], 'VERTICAL')
      end

      it 'returns HIT' do
        expect(@game.fire([0,0])).to eql('HIT')
      end
    end

    context 'given coordinates for the last square of a ship' do
      before do
        @game.place_ship(2, [0, 0], 'VERTICAL')
        @game.place_ship(3, [1, 0], 'VERTICAL')

        @game.fire([0,0])
      end

      it 'returns SUNK' do
        expect(@game.fire([0,1])).to eql('SUNK')
      end
    end

    context 'given coordinates that sink the last ship' do
      before do
        @game.place_ship(2, [0, 0], 'VERTICAL')
        @game.fire([0,0])
      end

      it 'returns WIN' do
        expect(@game.fire([0,1])).to eql('WIN')
      end
    end
  end
end
