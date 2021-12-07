input = File.read("day07_input.txt").chomp.split(",").map(&:to_i)

def nth_triangular_number(n)
  n * (n + 1) / 2
end

def solve(part, input)
  (low, high) = input.minmax
  (low..high).map do |pos|
    fuel = input.map do |i|
      diff = (i - pos).abs
      part == 1 ? diff : nth_triangular_number(diff)
    end.inject(:+)
    [pos, fuel]
  end.min_by{ |_a, b| b }[1]
end

p solve(1, input)
p solve(2, input)
