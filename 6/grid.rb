require 'set'

points = $<.each.map {|l| l.split(",").map(&:to_i)}

xs = points.map { |p| p[0] }
ys = points.map { |p| p[1] }
xmax = xs.max
ymax = ys.max

closest_count = Array.new(points.length, 0)
infinite_area = Set.new()

for ix in (0..xmax) do
    for iy in (0..ymax) do
        closest = -1
        min_d = Float::INFINITY

        for pt, i in points.each_with_index do
            d = (pt[0] - ix).abs + (pt[1] - iy).abs
            if d < min_d
                closest = i
                min_d = d
            elsif d == min_d
                closest = -1
            end
        end

        if closest != -1
            
            closest_count[closest] += 1

            if ix == 0 or iy == 0 or ix == xmax or iy == ymax
                infinite_area.add(closest)
            end
        end
    end
end

p infinite_area
p closest_count

p closest_count.each_with_index.reject { |v,i| infinite_area.include? i }.max