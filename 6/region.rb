require 'set'

points = $<.each.map {|l| l.split(",").map(&:to_i)}

xs = points.map { |p| p[0] }
ys = points.map { |p| p[1] }
xmax = xs.max
ymax = ys.max

region_size = 0

for ix in (0..xmax) do
    for iy in (0..ymax) do
        total_d = 0

        for pt, i in points.each_with_index do
            d = (pt[0] - ix).abs + (pt[1] - iy).abs
            total_d += d
        end

        region_size += 1 if total_d < 10000
    end
end

p region_size