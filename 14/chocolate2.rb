recipes = [3, 7]

elf_1 = 0
elf_2 = 1

n = "3301".chars.map(&:to_i)

loop do
    new_recipes = (recipes[elf_1] + recipes[elf_2]).to_s.chars.map(&:to_i)

    for recipe in new_recipes
        recipes.append recipe

        # for i in 1..n.length
        #     if recipes[-i] != n[-i]
        #         break 
        #     end
        #     if i == n.length
        #         p recipes.length - n.length
        #         exit
        #     end
        # end

        if recipes.length > n.length and recipes.slice(recipes.length - n.length, n.length) == n
            p recipes.length - n.length
            exit
        end
    end

    elf_1 = (elf_1 + recipes[elf_1] + 1) % recipes.length
    elf_2 = (elf_2 + recipes[elf_2] + 1) % recipes.length
end

