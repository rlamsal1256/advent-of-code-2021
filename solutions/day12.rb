class Graph
    attr_reader :v
    attr_accessor :big_caves
    attr_accessor :small_caves
    attr_accessor :adj_list
    attr_accessor :count
    attr_reader :part

    def initialize(v)
        @v = v
        @adj_list = {}
        @big_caves = []
        @small_caves = []
        @count = 0
        @part = 1
    end

    def set_part(part)
        @part = part
    end

    def init_adj_list(vertices)
        vertices.each do |ve|
            adj_list[ve] = []
        end
        find_big_caves(vertices)
        find_small_caves(vertices)
    end

    def find_big_caves(vertices)
        vertices.map{ |ve| 
            big_caves << ve if (ve.upcase <=> ve) == 0
        }
    end

    def find_small_caves(vertices)
        vertices.map{ |ve| 
            next if ve == "start" || ve == "end"
            small_caves << ve if (ve.downcase <=> ve) == 0
        }
    end

    def add_edge(v1,v2)
        adj_list[v1].push(v2)
    end

    def small_caves_count_limit_reached(visited, node)
        v_clone = visited.clone
        v_clone << node
        counts = small_caves.map{ |sc| v_clone.count(sc) }
        if counts.filter{ |c| c > 2 }.length > 0 || 
            counts.filter{ |c| c > 1 }.length > 1
            return true
        end

        return false
    end

    def visited?(node, visited)
        if part == 1
            !big_caves.include?(node) && visited.include?(node)
        else
            !big_caves.include?(node) && 
                small_caves_count_limit_reached(visited, node) &&
                visited.include?(node)
        end
    end

    def depth_first(visited, destination)
        nodes = adj_list[visited.last()]
        for node in nodes
            if visited?(node, visited)
                next
            end
            if node == destination
                visited.push(node)
                @count += 1
                # p visited
                visited.pop()
                break
            end
        end
        for node in nodes
            if visited?(node, visited) || node == destination
                next
            end
            visited << node 
            depth_first(visited, destination)
            visited.pop() 
        end
    end
end

def solve(input, part)
    vertices = input.flatten.uniq
    g = Graph.new(vertices.length)
    g.init_adj_list(vertices)
    
    input.each do |v1, v2|
        if v1 == "start" || v2 == "end"
            g.add_edge(v1, v2)
        elsif v1 == "end" || v2 == "start"
            g.add_edge(v2, v1)
        else
            g.add_edge(v1, v2)
            g.add_edge(v2, v1)
        end
    end
    
    g.set_part(part)
    g.depth_first(["start"], "end")
    p g.count
end

input = File.readlines("day12_input.txt").map{ |l| l.chomp.split("-") }

solve(input, 1)
solve(input, 2)
