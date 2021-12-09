# part 1
input = File.readlines("day08_input.txt")
output_values = input.map{ |l| l.split(" | ")[1].chomp.split }.flatten
p output_values.map(&:length).filter{ |o| [2,3,4,7].include?(o) }.count

# part 2
def combinations(hsh)
    attrs   = hsh.values
    keys    = hsh.keys
    all_combos = attrs[0].product(*attrs[1..-1])
    all_combos.filter{ |p| p.size == p.uniq.size }
end

def chars_w_len(inp, n); inp.find{ |w| w.length == n }.chars end

def deduce_rest(inp, combos)
    digits = {
        0 => [1,1,1,0,1,1,1],
        2 => [1,0,1,1,1,0,1],
        3 => [1,0,1,1,0,1,1],
        5 => [1,1,0,1,0,1,1],
        6 => [1,1,0,1,1,1,1],
        9 => [1,1,1,1,0,1,1]
    }

    h = inp.map{ |w| 
        missing_letters = ("abcdefg".chars - w.chars)
        combos_index = combos.map{ |c| c.map { |x| missing_letters.include?(x) ? 0 : 1 } }
        n = digits.find{ |i,l| combos_index.find{ |c| c == l} }[0]
        { w => n }
    }
    h.reduce Hash.new, :merge
end

lines = input.map{ |l| l.split(" | ").map{ |l| l.chomp.split.map{ |s| s.chars.sort.join } } }

p lines.map{ |i,o| 
    len_2, len_3, len_4, len_7 = [2,3,4,7].map{ |n| chars_w_len(i, n) }
    patterns = {
        len_2.join => 1,
        len_3.join => 7,
        len_4.join => 4,
        len_7.join => 8
    }
    h = {
        0 => len_3 - len_2, 
        1 => len_4 - len_2,
        2 => len_2,
        3 => len_4 - len_2,
        4 => len_7 - len_4 - len_3 - len_2,
        5 => len_2,
        6 => len_7 - len_4 - len_3 - len_2,
    }
    combos = combinations(h)
    i = i - [len_2, len_3, len_4, len_7].map(&:join)
    patterns = patterns.merge(deduce_rest(i, combos))
    o.map{ |w| patterns[w] }.join.to_i
}.inject(:+)
