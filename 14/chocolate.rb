recipes = [3, 7]

elf_1 = 0
elf_2 = 1

n = 330121

while recipes.length < n + 10
    #p recipes
    new_recipes = (recipes[elf_1] + recipes[elf_2]).to_s.chars.map(&:to_i)
    recipes.concat new_recipes
    elf_1 = (elf_1 + recipes[elf_1] + 1) % recipes.length
    elf_2 = (elf_2 + recipes[elf_2] + 1) % recipes.length
end

p recipes.drop(n)[0...10].map(&:to_s).join