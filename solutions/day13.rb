require "matrix"

def fold(m, at)
    new_m = (0..at-1).to_a.map{ |i| 
        m.row(i).to_a
            .zip(m.row(m.row_count - 1 - i).to_a)
            .map{ |d1, d2| (d1 == "#" || d2 == "#") ? "#" : "."}
    }
    Matrix[*new_m]
end

input = File.read("day13_input.txt").split("\n\n")
dots = input[0].split("\n").map{ |dot| dot.split(",").map(&:to_i) }
(x_len, y_len) = dots.transpose.map(&:max)
matrix = Matrix.build(y_len + 1, x_len + 1){ "." }
dots.each{ |x, y| matrix[y, x] = "#" }

instructions = input[1].gsub("fold along ", "").split("\n").map{ |s| s.split("=")}
matrix = instructions.inject(matrix){ |m, (how, at)| 
    at = at.to_i
    case how
        when "y"
            fold(m, at)
        when "x"
            fold(m.transpose, at).transpose
    end
}

matrix.to_a.each { |r| puts r.inspect}
p matrix.count("#")
