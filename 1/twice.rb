require 'set'
lines = File.new("input").readlines.map &:to_i
i = s = 0
n = lines.length
S = Set.new

S.add(s)

loop {
    s += lines[i % n]
    if S.include? s
        p s
        break
    end
    S.add s
    i += 1
}