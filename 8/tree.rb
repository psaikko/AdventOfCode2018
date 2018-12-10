tree_arr = $<.gets.split.map(&:to_i)
p tree_arr

$meta_sum = 0

def parse(tree_arr, i)
    n_children = tree_arr[i]
    i += 1
    n_meta = tree_arr[i]
    i += 1

    p "#{n_children} #{n_meta}"

    for child in 1..n_children do
        i = parse(tree_arr, i)
    end

    for meta in 1..n_meta do
        $meta_sum += tree_arr[i]
        i += 1
    end

    return i
end

parse(tree_arr, 0)

p $meta_sum