input = File.readlines("day10_input.txt").map{ |l| l.chomp.chars }

# part 1
opens = ["(", "[", "{", "<"]
closes = [")", "]", "}", ">"]
points = [3, 57, 1197, 25137]

corrupts = []
incompletes = input.map{ |line|
    stack = []
    line.filter{ |c|
        if opens.include?(c)
            stack << c
        else
            match = opens.find_index(stack.pop()) == closes.find_index(c)
            if match == false
                corrupts << c
                break
            end
        end
    }.nil? ? nil : stack
}.compact

p corrupts.map{ |c| points[closes.find_index(c)] }.inject(:+)

# part 2
points = [1,2,3,4]
arr = incompletes.map{ |line| 
    completes = line.map{ |c| 
        closes.at(opens.find_index(c))
    }.reverse
    completes.inject(0){ |score, c| 
        score *= 5
        score += points.at(closes.find_index(c))
    }
}.sort

p arr[(arr.length/2).ceil()]
