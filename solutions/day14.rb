input = File.read("day14_input.txt").split("\n\n")
template = input[0].chars

h = {}
input[1].split("\n").each{ |s| 
    (a, b) = s.split(" -> ")
    h[a] = b
}

def inc(x:, by:)
    x.nil? ? by : x + by
end

pair_count = {}
template.each_cons(2).map{ |l1, l2| 
    new_pair = [l1, l2].join
    pair_count[new_pair] = inc(x: pair_count[new_pair], by: 1)
}

41.times do |i|
    if i == 10 || i == 40
        el_count = {}
        el_count[template[-1]] = 1
        for k,v in pair_count
            el_count[k.chars[0]] = inc(x: el_count[k.chars[0]], by: v)
        end

        sorted = el_count.map{ |_k, v| v }.sort
        p sorted[-1] - sorted[0]
    end

    new_count = {}
    for k,v in pair_count
        new_count[k[0]+h[k]] = inc(x: new_count[k[0]+h[k]], by: pair_count[k])
        new_count[h[k]+k[1]] = inc(x: new_count[h[k]+k[1]], by: pair_count[k])
    end
    pair_count = new_count
end
