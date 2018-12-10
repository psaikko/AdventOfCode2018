tree_arr = $<.gets.split.map(&:to_i)
p tree_arr

def parse(tree_arr, i)
    n_children = tree_arr[i]
    i += 1
    n_meta = tree_arr[i]
    i += 1

    child_values = []

    p "#{n_children} #{n_meta}"

    for child in 1..n_children do
        i, v = parse(tree_arr, i)
        child_values << v
    end

    p "#{n_children} #{n_meta} #{child_values}"

    if n_children == 0
        meta_sum = 0
        for meta in 1..n_meta do
            meta_sum += tree_arr[i]
            i += 1
        end
        return i, meta_sum
    else
        child_sum = 0
        for meta in 1..n_meta do
            if tree_arr[i] > 0 and tree_arr[i] <= n_children
                child_sum += child_values[tree_arr[i] - 1]
            end
            i += 1
        end
        return i, child_sum
    end
end

p parse(tree_arr, 0)