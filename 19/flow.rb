require 'set'

addr = ->(r,a,b,c) { r[c] = r[a] + r[b] }
addi = ->(r,a,b,c) { r[c] = r[a] + b }
mulr = ->(r,a,b,c) { r[c] = r[a] * r[b] }
muli = ->(r,a,b,c) { r[c] = r[a] * b }
banr = ->(r,a,b,c) { r[c] = r[a] & r[b] }
bani = ->(r,a,b,c) { r[c] = r[a] & b }
borr = ->(r,a,b,c) { r[c] = r[a] | r[b] }
bori = ->(r,a,b,c) { r[c] = r[a] | b }

setr = ->(r,a,b,c) { r[c] = r[a] }
seti = ->(r,a,b,c) { r[c] = a }

gtir = ->(r,a,b,c) { r[c] = (a > r[b]) ? 1 : 0 }
gtri = ->(r,a,b,c) { r[c] = (r[a] > b) ? 1 : 0 }
gtrr = ->(r,a,b,c) { r[c] = (r[a] > r[b]) ? 1 : 0 }
eqir = ->(r,a,b,c) { r[c] = (a == r[b]) ? 1 : 0 }
eqri = ->(r,a,b,c) { r[c] = (r[a] == b) ? 1 : 0 }
eqrr = ->(r,a,b,c) { r[c] = (r[a] == r[b]) ? 1 : 0 }

ops =  {
    "addr" => addr,
    "addi" => addi,
    "mulr" => mulr,
    "muli" => muli,
    "banr" => banr,
    "bani" => bani,
    "borr" => borr,
    "bori" => bori,
    "setr" => setr,
    "seti" => seti,
    "gtir" => gtir,
    "gtri" => gtri,
    "gtrr" => gtrr,
    "eqir" => eqir,
    "eqri" => eqri,
    "eqrr" => eqrr,
}

input = $<.each.map(&:strip)

ip = input.shift().split()[1].to_i

input.map!{|l|
    l = l.split()
    instr = l.shift()
    args = l.map(&:to_i)
    [instr]+args
}

regs = [0] * 6
#regs[0] = 1
cycles = 0
while regs[ip] < input.length do
    #p regs
    cycles += 1
    opname, a, b, c = input[regs[ip]]

    ops[opname].call(regs, a, b, c)

    regs[ip] += 1
end

p cycles
p regs[0]
p regs