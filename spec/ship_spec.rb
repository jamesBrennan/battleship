RSpec.describe Ship do
  describe '.initialization' do
    it 'accepts length, origin, and orientation' do
      ship = Ship.new(2)
      expect(ship.length).to eql(2)
    end
  end

  describe '.hit' do
    before do
      @ship = Ship.new(2)
    end

    it 'increments the @hits counter' do
      expect { @ship.hit }.to change { @ship.hits }.by(1)
    end
  end

  describe '.sunk?' do
    context 'given a ship that has been hit length times' do
      before do
        @ship = Ship.new(2)
        @ship.hit
        @ship.hit
      end

      it 'returns true' do
        expect(@ship.sunk?).to be_truthy
      end
    end

    context 'given a ship that has been hit < length times' do
      before do
        @ship = Ship.new(2)
        @ship.hit
      end

      it 'returns false' do
        expect(@ship.sunk?).to be_falsey
      end
    end

  end
end
