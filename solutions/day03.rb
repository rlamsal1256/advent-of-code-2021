input = File.read("day03_input.txt").lines.map{ |b| b.strip!}

# part 1
p input
    .map(&:chars)
    .transpose
    .map{ |t| t.count("0") > t.count("1") ? [0, 1] : [1, 0]} # [gamma, epsilon]
    .transpose
    .map{ |r| r.join.to_i(2) }
    .inject(:*)

# part 2
def max_at_i(inp, i) inp.map(&:chars).transpose.at(i) end

def max_o2_at_i(inp, i)
    t = max_at_i(inp, i)
    t.count("0") > t.count("1") ? "0" : "1"
end

def max_co2_at_i(inp, i)
    t = max_at_i(inp, i)
    t.count("0") > t.count("1") ? "1" : "0"
end

def calc(input, func)
    (0..input.length)
    .inject(input){ |rem, index|
        break rem.at(0).to_i(2) if rem.length == 1
        max = method(func).call(rem, index)
        rem.filter{ |item| item[index] == max }
    }
end

p calc(input, :max_o2_at_i) * calc(input, :max_co2_at_i)

