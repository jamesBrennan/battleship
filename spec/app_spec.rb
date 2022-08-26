RSpec.describe App do
  def app
    App
  end

  describe '.add' do
    it 'sums the arguments' do
      expect(app.add(2, 2)).to eq 4
    end
  end
end
