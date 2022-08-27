class App
  def self.max_subarray(input)
    len = input.length - 1
    value = -1_000_000_000

    (0..len).each do |start_index|
      (start_index..len).each do |end_index|
        subarray = input[start_index..end_index]
        value = [subarray.sum, value].max
      end
    end

    value
  end
end
