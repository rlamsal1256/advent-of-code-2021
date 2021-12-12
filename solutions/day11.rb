require 'matrix'

input = File.readlines("day11_input.txt").map{ |l| l.chomp.chars.map(&:to_i) }
m = Matrix[*input]

def adjacent(x, y)
    up = x - 1
    right = y + 1
    down = x + 1
    left = y - 1
    
    n = up < 0 ? nil : [up, y]
    ne = (up < 0 || right == 10) ? nil : [up, right]
    e = right == 10 ? nil : [x, right]
    se = (down == 10 || right == 10) ? nil : [down, right]
    s = down == 10 ? nil : [down, y]
    sw = (down == 10 || left < 0) ? nil : [down, left]
    w = left < 0 ? nil : [x, left]
    nw = (up < 0 || left < 0) ? nil : [up, left]
    [n, ne, e, se, s, sw, w, nw]
end

def lopptyloop(m, v, x, y, c, i) 
    if v > 9
        c += 1
        m[x,y] = 0
        adjacent(x,y).compact.map{ |xx, yy| 
            m[xx, yy] += m[xx, yy] == 0 ? 0 : 1
            (c, i) = lopptyloop(m, m[xx, yy], xx, yy, c, i) 
        }
    end
    [c, i]
end

def all_flash?(m)
    m.filter{ |el| el == 0 }.size == 100
end
  
c = 0
100.times.each { |i|
    m = m + Matrix.build(10){ 1 }
    m.each_with_index{ |v, x, y| 
        (c, i) = lopptyloop(m, v, x, y, c, i) 
    }
}
p "part 1: #{c}"

c = 0
i = 0
until all_flash?(m)
    i += 1
    m = m + Matrix.build(10){ 1 }
    m.each_with_index{ |v, x, y| 
        (c, i) = lopptyloop(m, v, x, y, c, i) 
    }
end
p "part 2: #{i}"
