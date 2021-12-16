# source: https://raw.githubusercontent.com/mburst/dijkstras-algorithm/master/dijkstras.rb
require 'priority_queue'

class Graph
    def initialize()
        @vertices = {}
    end
  
    def add_vertex(name, edges)
        @vertices[name] = edges
    end
    
    def shortest_path(start, finish)
        maxint = (2**(0.size * 8 -2) -1)
        distances = {} # Distance from start to node
        previous = {} # Previous node in optimal path from source
        nodes = PriorityQueue.new # Priority queue of all nodes in Graph
        
        @vertices.each do | vertex, value |
            if vertex == start # Set root node as distance of 0
                distances[vertex] = 0
                nodes[vertex] = 0
            else
                distances[vertex] = maxint
                nodes[vertex] = maxint
            end
            previous[vertex] = nil
        end
        
        while nodes
            smallest = nodes.delete_min_return_key # Vertex in nodes with smallest distance in distances
            
            if smallest == finish # If the closest node is our target we're done so print the path
                path = []
                while previous[smallest] # Traverse through nodes til we reach the root which is 0
                    path.push(smallest)
                    smallest = previous[smallest]
                end
                return path
            end
            
            if distances[smallest] == maxint or smallest == nil # All remaining vertices are inaccessible from source
                break            
            end
            
            @vertices[smallest].each do | neighbor, value | # Look at all the nodes that this vertex is attached to
                alt = distances[smallest] + @vertices[smallest][neighbor] # Alternative path distance
                if alt < distances[neighbor] # If there is a new shortest path update our priority queue (relax)
                    distances[neighbor] = alt
                    previous[neighbor] = smallest
                    nodes[neighbor] = alt
                end
            end
        end
        return distances
    end
    
    def to_s
        return @vertices.inspect
    end
end
