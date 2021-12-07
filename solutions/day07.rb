input = File.read("day07_input.txt").chomp.split(",").map(&:to_i)

def nth_triangular_number(n)
  n * (n + 1) / 2
end

def solve(part, input)
  (low, high) = input.minmax
  (low..high).map do |pos|
    if part == 1
      fuel = input.map{ |i| (i - pos).abs }.inject(:+)
    else
      fuel = input.map{ |i| nth_triangular_number((i - pos).abs) }.inject(:+)
    end
    [pos, fuel]
  end.min_by{ |_a, b| b }[1]
end

p solve(1, input)
p solve(2, input)
