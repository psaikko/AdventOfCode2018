require 'set'

regex = $<.read.strip
p regex

$graph = Hash.new() {|h,k| h[k] = Set.new}

def traverse locs, r, i

    while i < r.length do
        case r[i]
        when "("            
            new_locs = []
            branches = 0
            while true
                branch, i = traverse(locs.map(&:clone), r, i+1)
                branches += 1
                new_locs.concat(branch)
                if r[i] != "|"
                    break
                    p i
                    p r[j..i]
                    p r[(i+1)..(i+10)]
                    p :asdf
                    exit
                end
            end

            locs = new_locs
        when "|"
            return locs, i
        when ")"
            return locs, i
        when "$"
            return locs, i
        when /[NSEW]/
            d = {"N" => [-1,0],
             "S" => [1, 0],
             "E" => [0, 1],
             "W" => [0,-1]}[$&]

            locs.map!{|from|
                x, y = from
                to = [x+d[1],y+d[0]]

                $graph[from].add(to)
                $graph[to].add(from)

                to
            }
            locs = Set.new(locs).to_a
        end
        i += 1
    end
end

x = 0
y = 0
i = 0

p traverse [[x, y]], regex, i

p $graph

p $graph.keys.minmax_by{|p| p[0]}
p $graph.keys.minmax_by{|p| p[1]}

seen = Set.new
dist = Hash.new

lq = [[0,0]]
dq = [0]

max_d = 0
n_1000 = 0

while lq.length > 0 do
    l = lq.shift
    d = dq.shift

    seen.add l
    dist[l] = d

    max_d = [d, max_d].max
    n_1000 += 1 if d >= 1000

    for n in $graph[l] do
        if not seen.include? n 
            lq.push(n)
            dq.push(d+1)
        end
    end

end

p max_d, n_1000