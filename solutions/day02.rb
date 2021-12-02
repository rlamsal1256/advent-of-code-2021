def new_pos_part_1(x, y, dir, val)
    case dir
    when 'forward'
        [x + val, y]
    when 'down'
        [x, y + val]
    when 'up'
        [x, y - val]
    end
end

def new_pos_part_2(x, y, aim, dir, val)
    case dir
    when 'forward'
        [x + val, y + (aim * val), aim]
    when 'down'
        [x, y, aim + val]
    when 'up'
        [x, y, aim - val]
    end
end

input = File.read("day02_input.txt").lines.map(&:split)
p input.inject([0 ,0]){ |(x, y), (dir, val)| new_pos_part_1(x, y, dir, val.to_i) }.inject(:*)
(pos, depth, _) = input.inject([0 ,0, 0]){ |(x, y, a), (dir, val)| new_pos_part_2(x, y, a, dir, val.to_i) }
p pos*depth
