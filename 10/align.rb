vals = $<.each.map { |l| l.match(/position=<\s*(-?\d+),\s*(-?\d+)> velocity=<\s*(-?\d+),\s*(-?\d+)>\s*/).captures }
vals = vals.each.map { |a| a.map(&:to_i) }

xrange = Float::INFINITY

100000.times do |i|

    vals.each do |l|
        l[0] += l[2]
        l[1] += l[3]
    end

    xs = vals.map{|l| l[0]}
    ys = vals.map{|l| l[1]}

    xmin, xmax = xs.min, xs.max
    ymin, ymax = ys.min, ys.max

    new_xrange = xmax - xmin
    break if new_xrange > xrange
    xrange = new_xrange

    if xmax - xmin < 100

        m = Array.new(ymax - ymin + 1) { |i| Array.new(xmax - xmin + 1, ' ') }

        vals.each do |px, py, vx, vy|
            m[py - ymin][px - xmin] = '#'
        end

        m.map { |l| p l.join }
        p i+1
    end
end
