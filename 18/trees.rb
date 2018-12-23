lines = $<.each.map(&:strip)

n = lines[0].length

def adjacent(r, c)
    adj = []
    for r_ in (r-1)..(r+1) do
        for c_ in (c-1)..(c+1) do
            if not (r == r_ and c == c_) 
                adj << [r_, c_]
            end
        end
    end
    adj
end

lines.map!{|l| " "+l+" "}

lines.unshift(" "*(n+2))
lines.push(" "*(n+2))

lines.each{|l|p l}

state = lines

cache = Hash.new()
cache[state.join] = 0

i = 1
while i <= 1000000000 do
    new_state = state.map(&:clone)

    for r in 1..n do
        for c in 1..n do
            adj_tiles = adjacent(r,c).map{|r,c| state[r][c]}
            n_trees = adj_tiles.count{|t| t=='|'}
            n_open = adj_tiles.count{|t| t=='.'}
            n_lumber = adj_tiles.count{|t| t=='#'}
            case state[r][c]
            when "."
                new_state[r][c] = "|" if n_trees >= 3
            when "#"
                new_state[r][c] = "." if not (n_lumber >= 1 and n_trees >= 1)
            when "|"
                new_state[r][c] = "#" if n_lumber >= 3
            end
        end
    end

    state = new_state
    #state.each{|l|p l}
    state_str = state.join
    if not cache.key? state_str
        cache[state_str] = i
        i += 1
    else
        p :loops, i, cache[state_str]
        cycle = i - cache[state_str]
        while i + cycle <= 1000000000
            i += cycle
        end
        i += 1
    end
end

n_trees = state.join.chars.count{|t| t=='|'}
n_lumber = state.join.chars.count{|t| t=='#'}

p n_trees * n_lumber