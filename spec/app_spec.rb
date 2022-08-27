RSpec.describe App do
  def app
    App
  end

  describe '.max_subarray' do
    it 'returns the value of the largest summed subarray' do
      expect(App.max_subarray([-1, 1, 22, -33, 5])).to eq 23
      expect(App.max_subarray([100, 50, 10, 20])).to eq 180
      expect(App.max_subarray([-100, -10, -20, -50])).to eq -10
    end
  end
end
