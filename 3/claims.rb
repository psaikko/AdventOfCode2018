#!/usr/bin/env ruby
require 'set'
lines = File.new("input").readlines()

N = 1010
G = Array.new(N) { Array.new(N, 0) }

S = Set.new()

lines.each do |l| 
    id, x, y, w, h = *(l.scan(/\d+/).map(&:to_i))

    S.add(id)

    for ix in x..(x+w-1) do
        for iy in y..(y+h-1) do
            if G[iy][ix] != 0
                S.delete(G[iy][ix])
                S.delete(id)
            end
            G[iy][ix] = id
        end
    end
end

c = 0
for i in 0..(N-1) do
    for j in 0..(N-1) do
        c += 1 if G[i][j] > 1
    end
end

puts S