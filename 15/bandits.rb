require "set"

$map = $<.each.map(&:strip).map(&:chars)
p $map
$units = []
$map.each_with_index do |row, y|
    row.each_with_index do |ch, x| 
        if ch == 'G' or ch == 'E'
            $units << [y,x,200,ch]
            $map[y][x] = '.'
        end
    end
end

def unit_map 
    um = $map.map(&:clone)
    for y, x, hp, type in $units
        um[y][x] = type
    end
    return um
end

def dist_map from

    dists = unit_map

    deque = Array.new

    from << 0
    deque.push from

    dists[from[0]][from[1]] = 0

    while deque.length > 0 do
        y, x, d = deque.shift

        [[y+1,x],[y-1,x],[y,x-1],[y,x+1]].each{ |yn,xn|
            if dists[yn][xn] == '.' 
                dists[yn][xn] = d+1
                deque << [yn,xn,d+1]
            end
        }
    end

    return dists
end

$is_dead = -> u { u[2] <= 0 }

# def is_dead u
#     u[2] <= 0
# end

def adj pt
    return [[pt[0]-1,pt[1]], [pt[0]+1,pt[1]], [pt[0],pt[1]-1], [pt[0],pt[1]+1]]
end

def neighbors pt
    return adj(pt).reject{ |y,x| 
        $map[y][x] != '.'
    }
end

def dist pt1, pt2
    return 0 if (pt1[0] - pt2[0]).abs + (pt1[1] - pt2[1]).abs == 0
    #p pt1, pt2
    m = dist_map pt1
    #print_map m
    m[pt2[0]][pt2[1]]
end

def loc unit
    return unit[0..1]
end

def race unit
    return unit[3]
end

def print_map m
    m.map(&:join).each{|l| p l}
end

def do_move unit
    targets = []
    for unit2 in $units.reject(&$is_dead)
        if race(unit) != race(unit2)
            targets.concat neighbors(loc(unit2))
        end
    end

    # no valid targets
    return false if targets.length == 0

    targets.reject!{ |ty,tx| unit_map[ty][tx] != '.' and [ty,tx] != unit[0..1]}

    dists_targets = targets.map { |target_loc| [dist(loc(unit), target_loc)] + target_loc }

    dists_targets.reject!{|t| not t[0].is_a? Numeric}

    # p dists_targets
    dists_targets.sort!

    # no valid paths
    return true if dists_targets.length == 0

    # already adjacent
    return true if dists_targets[0][0] == 0

    # filter out blocked targets
    #dists_targets.reject!{ |td,ty,tx| unit_map[ty][tx] != '.'}

    # p dists_targets

    # no valid targets
    return true if dists_targets.length == 0

    td, ty, tx = dists_targets[0]

    dists = dist_map [ty,tx]

    #print_map unit_map
    #p targets.map { |target_loc| [dist(loc(unit), target_loc)] + target_loc }
    #p targets.map { |y,x| [unit_map[y][x], y, x] }
    #p dists_targets
    #print_map dists

    neighbors = adj loc(unit)

    neighbor_dists = neighbors.map{ |y,x| 
        (dists[y][x].is_a? Integer) ? [dists[y][x],y,x] : nil
    }.reject{|a| a == nil}.sort

    return true if neighbor_dists.length == 0

    md, my, mx = neighbor_dists[0]

    unit[0] = my
    unit[1] = mx

    return true
end

p $units
p $map

print_map unit_map

last_round = nil
(1..1000).each do |round|

    $units.reject!(&$is_dead)

    $units.sort!

    completed_round = true

    p round

    for unit in $units #.reject(&$is_dead)

        print_map unit_map

        next if $is_dead.call(unit)

        if not do_move(unit) 
            completed_round = false
            break
        end

        #p unit.to_s+" has target"

        adj = neighbors(loc(unit))
        adj_enemies = []

        for unit2 in $units #.reject(&$is_dead)

            next if $is_dead.call(unit2)

            if race(unit) != race(unit2) and adj.include? loc(unit2)
                adj_enemies << unit2
            end
        end

        #p adj_enemies

        if adj_enemies.length > 0
            adj_enemies.sort_by! { |u| [u[2],u[0],u[1]] }
            #p unit.to_s + "  -->  " + adj_enemies[0].to_s
            target = adj_enemies[0]
            target[2] -= 3
        end

    end

    #$units.reject!(&$is_dead)

    #$units.each{|u| p u}
    print_map unit_map

    #races = Set.new($units.reject(&$is_dead).map(&:reverse).map(&:first))
    #p races
    #if races.size == 1
    if not completed_round
        last_round = round - 1
        break
    end

end

hp_sum = $units.reject(&$is_dead).map{|u| u[2]}.inject(:+)
p $units.reject(&$is_dead)
p last_round
p hp_sum
p hp_sum * last_round