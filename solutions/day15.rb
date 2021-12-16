require 'matrix'
require './graph'

def adjacent((x, y), (w, h))
    up = y - 1 < 0 ? nil : [y - 1, x]
    down = y + 1 > h ? nil : [y + 1, x]
    left = x - 1 < 0 ? nil : [y, x - 1]
    right = x + 1 > w ? nil : [y, x + 1]
    [up, down, left, right]
end

def solve(input, part)
    m = Matrix[*input]

    if part == 2
        m = 4.times.inject([m, m]){ |(acc1, acc2), _| 
            m2 = Matrix[*acc2.map{ |v| v == 9 ? 1 : (v + 1) }]
            x = (0..m2.row_count-1).to_a.map{ |i| 
                acc1.row(i).to_a.concat(m2.row(i).to_a)
            }
            m1 = Matrix[*x]
            [m1, m2]
        }[0]

        m = 4.times.inject([m, m]){ |(acc1, acc2), _| 
            m2 = Matrix[*acc2.map{ |v| v == 9 ? 1 : (v + 1) }]
            x = (0..m2.column_count-1).to_a.map{ |i| 
                acc1.column(i).to_a.concat(m2.column(i).to_a)
            }.transpose
            m1 = Matrix[*x]
            [m1, m2]
        }[0]
    end

    g = Graph.new
    r_len = m.row_count - 1
    c_len = m.column_count - 1

    m.each_with_index.map{ |v, y, x| 
        n = [x, y]
        edges = {}
        adjacent([x, y], [c_len, r_len]).compact.map{ |y1, x1| 
            edges[[x1, y1]] = m[y1, x1]
        }
        g.add_vertex([x, y], edges)
    }

    p g.shortest_path([0,0], [c_len, r_len]).map{ |x, y| m[y, x] }.inject(:+)
end

input = File.readlines("day15_input.txt").map{ |l| l.chomp.chars.map(&:to_i) }
solve(input, 1)
solve(input, 2)
