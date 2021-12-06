input = File.read("day05_input.txt").split("\n")

def connect_dots(x1, y1, x2, y2, include_diagonal)
  if x1 == x2
    min, max = y1 < y2 ? [y1, y2] : [y2, y1]
    (min..max).to_a.map{ |n| [x1, n] }
  elsif y1 == y2
    min, max = x1 < x2 ? [x1, x2] : [x2, x1]
    (min..max).to_a.map{ |n| [n, y1] }
  elsif include_diagonal
    x_list = x1 < x2 ? (x1..x2).to_a : (x2..x1).to_a.reverse
    y_list = y1 < y2 ? (y1..y2).to_a : (y2..y1).to_a.reverse
    x_list.zip(y_list)
  end
end

def get_all_coords(input, include_diagonal)
  input
    .map do |line|
      m = /(\d+),(\d+) -> (\d+),(\d+)/.match(line)
      [m[1].to_i, m[2].to_i, m[3].to_i, m[4].to_i]
    end
    .filter do |x1, y1, x2, y2|
      horizontal_or_vertical = x1 == x2 || y1 == y2
      diagonal = (x2 - x1).abs == (y2 - y1).abs
      include_diagonal ? (horizontal_or_vertical || diagonal) : horizontal_or_vertical
    end
    .map do |x1, y1, x2, y2| connect_dots(x1, y1, x2, y2, include_diagonal) end
    .flatten
    .each_slice(2)
    .to_a
end

def count_overlap_points(input, include_diagonal: false)
  coords = get_all_coords(input, include_diagonal)
  (x_len, y_len) = coords.transpose.map(&:max)
  board = Array.new(y_len + 1) { Array.new(x_len + 1) { 0 } }
  coords.map{ |x, y| board[y][x] = board[y][x] + 1 }
  board.flatten.count{ |n| n >= 2}
end

p count_overlap_points(input)
p count_overlap_points(input, include_diagonal: true)
