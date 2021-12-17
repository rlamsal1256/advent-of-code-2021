$v = 0

def get(p, i); p.shift(i).join.to_i(2) end

def decode(packet)
    $v += get(packet, 3)
    type_id = get(packet, 3)

    if type_id == 4
        packet.shift(4) while packet.shift == "1"
        packet.shift(4)
    else 
        if packet.shift == "0"
            sub_packet = packet.shift(get(packet, 15))
            decode(sub_packet) until sub_packet.empty?
        else
            get(packet, 11).times{ decode(packet) }
        end
    end
end

input = File.read("day16_input.txt").chomp.chars.map{ |c| c.hex.to_s(2).rjust(4, "0").chars}.flatten
decode(input)
p $v
