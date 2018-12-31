#n = 864
n = 10551264
s = 0

for i in 1..n do
    if n % i == 0
        s += i
    end
end

p s