require "matrix"

input = File.readlines("day09_input.txt").map{ |l| l.chomp.chars.map(&:to_i) }

# part 1
w = input[0].length
h = input.length
m = Matrix[*input]

def adjacent(_m, (x, y), (w, h))
  up = x - 1 < 0 ? nil : [x - 1, y]
  down = x + 1 == h ? nil : [x + 1, y]
  left = y - 1 < 0 ? nil : [x, y - 1]
  right = y + 1 == w ? nil : [x, y + 1]
  [up, down, left, right]
end

low_points = input.each_with_index.map do |x, i|
  x.each_with_index.filter do |y, j|
    adjacent(m, [i, j], [w, h]).map do |new_x, new_y|
      new_x.nil? ? 10 : m[new_x, new_y]
    end.all?{ |v| v > y }
  end
    .map(&:last)
    .map{ |j| [i, j] }
end.flatten.each_slice(2).to_a

p low_points.map{ |x, y| m[x, y] + 1 }.inject(:+)

# part 2
def basin(m, (x, y), (w, h), list)
  return if m[x, y] == 9
  return if list.include? [x, y]

  list << [x, y]
  adjacent(m, [x, y], [w, h]).map do |new_x, new_y|
    next if new_x.nil?
    basin(m, [new_x, new_y], [w, h], list)
  end
end

p low_points.map{ |x, y|
  list = []
  basin(m, [x, y], [w, h], list)
  list.length
}.sort.last(3).inject(:*)
