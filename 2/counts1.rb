#!/usr/bin/env ruby
threes = 0
twos   = 0
File.open("input").each do |line|
    counts = Hash.new(0)

    line.each_char do |c|
        counts[c] += 1;
    end

    threes += 1 if counts.has_value?(3)
    twos += 1 if counts.has_value?(2)
end

puts threes*twos