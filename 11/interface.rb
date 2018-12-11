$serial = 6042

def power(x,y) 
    id = x + 10
    pow = id * y
    pow += $serial
    pow *= id
    pow = (pow % 1000) / 100
    return pow - 5
end

cells = Array.new(302) { |y| Array.new(302) { |x| power(x,y) } }

sums  = Array.new(302) { Array.new(302, 0) }

for i in 1..301 do
    for j in 1..301 do
        sums[i][j] = sums[i][j-1] + sums[i-1][j] - sums[i-1][j-1] + cells[i][j]
    end
end

max_pos = nil
max_val = -100

for s in 1..300 do
    for i in 1..(301-s) do
        for j in 1..(301-s) do
            val = sums[i+s][j+s] - sums[i+s][j] - sums [i][j+s] + sums[i][j]
            if val > max_val
                max_val = val
                max_pos = [j+1, i+1, s]
            end
        end
    end
end

p max_val
p max_pos