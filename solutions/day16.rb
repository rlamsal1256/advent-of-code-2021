$v = 0

def get(p, i)
  p.shift(i).join.to_i(2)
end

def decode(packet)
  $v += get(packet, 3)
  type = get(packet, 3)

  if type == 4
    val = []
    val << packet.shift(4) while packet.shift == "1"
    val << packet.shift(4)
    [type, val.flatten.join.to_i(2)]
  else
    if packet.shift == "0"
      sub_packets = []
      packets = packet.shift(get(packet, 15))
      sub_packets << decode(packets) until packets.empty?
    else
      sub_packets = get(packet, 11).times.map{ decode(packet) }
    end
    [type, sub_packets]
  end
end

input = File.read("day16_input.txt").chomp.chars.map{ |c| c.hex.to_s(2).rjust(4, "0").chars}.flatten
packet = decode(input)
p $v

def eval(packet)
  case packet.first
  when 0; packet.last.map(&method(:eval)).reduce(:+)
  when 1; packet.last.map(&method(:eval)).reduce(:*)
  when 2; packet.last.map(&method(:eval)).min
  when 3; packet.last.map(&method(:eval)).max
  when 4; packet.last
  when 5; packet.last.map(&method(:eval)).reduce(:>) ? 1 : 0
  when 6; packet.last.map(&method(:eval)).reduce(:<) ? 1 : 0
  when 7; packet.last.map(&method(:eval)).reduce(:==) ? 1 : 0
  end
end

p eval(packet)
