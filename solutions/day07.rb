input = File.read("day07_input.txt").chomp.split(",").map(&:to_i)

def nth_triangular_number(n)
  n * (n + 1) / 2
end

def solve(part, input)
  (low, high) = input.minmax
  (low..high).map do |pos|
    input.map do |i|
      diff = (i - pos).abs
      part == 1 ? diff : nth_triangular_number(diff)
    end.inject(:+)
  end.min
end

p solve(1, input)
p solve(2, input)
