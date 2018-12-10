require "set"
A = $<.each.map {|s| s.match(/Step (.) must be finished before step (.) can begin./i).captures}
$edges = Hash.new { |h,k| h[k] = [] }
A.each {|a,b| 
    $edges[a] << b
}
$edges.each_key {|k| $edges[k].sort!}
p $edges
sorted_nodes = Set.new(A.flatten).to_a.sort
p sorted_nodes

$node_state = Hash.new { |h,k| h[k] = 0}
$topo_order = ""

def dfs(i)
    $node_state[i] = 1
    $edges[i].reverse_each do |neighbor|
        case $node_state[neighbor]
        when 0
            dfs(neighbor)
        when 1
            throw "cycle"
        when 2
            nil
        end
    end
    $topo_order += i    
    $node_state[i] = 2
end

sorted_nodes.reverse_each do |i|
    if $node_state[i] == 0
        dfs(i)
    end
end

$topo_order.reverse!
p $node_state
p $topo_order

reverse_edges = {}
sorted_nodes.each { |n| reverse_edges[n] = [] }
$edges.each_key { |k| $edges[k].each { |v| reverse_edges[v] << k}}

p reverse_edges

$topo_order.clear

while sorted_nodes.length > 0
    for i in sorted_nodes do
        if reverse_edges[i].length == 0
            $topo_order += i
            sorted_nodes.delete(i)
            reverse_edges.each_value { |l| l.delete(i) }
            break
        end        
    end
end

p $topo_order