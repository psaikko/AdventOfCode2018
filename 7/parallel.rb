require "set"
A = $<.each.map {|s| s.match(/Step (.) must be finished before step (.) can begin./i).captures}
edges = Hash.new { |h,k| h[k] = [] }
A.each {|a,b| 
    edges[a] << b
}
edges.each_key {|k| edges[k].sort!}
p edges
sorted_nodes = Set.new(A.flatten).to_a.sort
p sorted_nodes

reverse_edges = {}
sorted_nodes.each { |n| reverse_edges[n] = [] }
edges.each_key { |k| edges[k].each { |v| reverse_edges[v] << k}}

p reverse_edges

workers = Array.new(5) { |i| [0,nil] }

p workers
time = 0

while sorted_nodes.length > 0
    p workers
    if not workers.map {|p| p[1]}.include? nil
        new_time, node = workers.min
        time = new_time
        reverse_edges.each_value { |l| l.delete(node) }

        workers.min[1] = nil
    end

    new_work = false
    if workers.map {|p| p[1]}.include? nil
        for node in sorted_nodes do
            if reverse_edges[node].length == 0
                sorted_nodes.delete(node)
                
                i = workers.find_index { |p| p[1] == nil }

                p "#{node} to worker #{i}"

                workers[i] = [(time + node.ord - 4), node]
                new_work = true
                break
            end        
        end
    end

    if not new_work 
        p "no work"
        new_time, node = workers.reject {|p| p[1] == nil}.min
        time = new_time
        p "#{new_time} #{node}"
        reverse_edges.each_value { |l| l.delete(node) }

        workers.reject {|p| p[1] == nil}.min[1] = nil
    end    
end

p workers.max