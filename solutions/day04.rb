def solve_all_bingo_boards(nums, boards)
    boards.map do |board|
      i = 5
      loop do
        win = board.find{ |l| (l - nums.take(i)).empty? }
        win ? break : i += 1
      end
      unmarked_sum = board.map{ |l| l - nums.take(i) }
        .flatten.uniq.map(&:to_i).inject(:+)
      [i, unmarked_sum]
    end
end

drawn_nums_str, *rest = File.read("day04_input.txt").lines.map(&:strip).delete_if(&:empty?)
drawn_nums = drawn_nums_str.split(",")
boards = rest.each_slice(5).each_with_index
    .map do |a_s, _i|
        a_a = a_s.map{ |s| s.split(" ") }
        a_a + a_a.transpose
    end
solved_boards = solve_all_bingo_boards(drawn_nums, boards).sort{ |a, b| a[0] <=> b[0] }

(turns, sum) = solved_boards.first
p drawn_nums[turns - 1].to_i * sum

(turns, sum) = solved_boards.last
p drawn_nums[turns - 1].to_i * sum
  