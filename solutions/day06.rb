input = File.read("day06_input.txt").chomp.split(",").map(&:to_i)

fishes = {1=>0, 2=>0, 3=>0, 4=>0, 5=>0}
for i in input do fishes[i] += 1 end

257.times do |day|
    if day == 80 || day == 256
        p [day, fishes.values().inject(:+)]
    end

    new_fishes = {0=>0, 1=>0, 2=>0, 3=>0, 4=>0, 5=>0, 6=>0, 7=>0, 8=>0}
    fishes.each do |age, num_fishes|
        if age == 0
            new_fishes[6] += num_fishes
            new_fishes[8] += num_fishes
        else
            new_fishes[age - 1] += num_fishes
        end
    end
    fishes = new_fishes
end
