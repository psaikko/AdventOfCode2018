#!/usr/bin/env ruby
lines = File.readlines("input")
n = lines.length

for i in 0..(n-2) do
    for j in i..(n-1) do
        d = 0
        m = lines[i].length

        for k in 0..(m-1) do
            if lines[i][k] != lines[j][k] 
                d += 1
            end
            if d > 1 
                break
            end
        end

        if d == 1
            puts lines[i]
            puts lines[j]
            exit()
        end
    end
end

