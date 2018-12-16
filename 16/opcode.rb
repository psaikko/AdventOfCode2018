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

ops =  [["addr",addr], ["addi",addi], ["mulr",mulr], ["muli",muli], 
        ["banr",banr], ["bani",bani], ["borr",borr], ["bori",bori], 
        ["setr",setr], ["seti",seti], ["gtir",gtir], ["gtri",gtri], 
        ["gtrr",gtrr], ["eqir",eqir], ["eqri",eqri], ["eqrr",eqrr]]

inputs = $<.each.map(&:strip)

$i = 0
inputs = inputs.chunk{ |x| 
    if x == ""
        $i += 1
        nil
    else
        $i
    end
}.to_a.map{|a| a[1]}

tests = inputs.take_while{|a| a.length == 3}
program = inputs.drop_while{|a| a.length == 3}

ctr = 0

candidates = Array.new(ops.length) {|i| Set.new}

for before, instr, after in tests
    regs = eval(before.split[1..-1].join)
    target = eval(after.split[1..-1].join)

    matching = 0

    opcode, a, b, c = instr.split.map(&:to_i)

    cds = Set.new

    for name_op, i in ops.each_with_index
        name, op = name_op
        tmp = regs.clone
        op.call(tmp,a,b,c)
        if tmp == target
            matching += 1
            cds.add(i)
        end
    end

    candidates[opcode].merge(cds)

    #p matching
    ctr += 1 if matching > 2
end

p ctr

units = Set.new

while true
    converged = true

    candidates.reject{|s| s.size > 1}.each{|s| units.merge s}

    for s in candidates 
        oldsize = s.size
        if s.size > 1
            for unit in units
                s.delete unit
            end
        end

        if s.size != oldsize
            converged = false
        end
    end

    break if converged
end

opcode_map = candidates.map(&:first).map{|i| ops[i][1]}

regs = [0,0,0,0]

for instr in program[0]
    opcode, a, b, c = instr.split.map(&:to_i)
    opcode_map[opcode].call(regs, a, b, c)
end

p regs