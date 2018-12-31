#ip 4
a = b = c = d = e = ip = 0

ip=0; ip = ip + 16 # GOTO B
step = 0
start = 1

loop do
    if start == 0
        ip=1; b = 1 if step <= 0 # E
        ip=2; d = 1 if step <= 1 # F
        ip=3; c = b * d if step <= 2# C

        if c == e
            c = 1
            ip=7; a = b + a
            p b
        else 
            c = 0
        end

        ip=8; d += 1 # D
        if d > e
            c = 1
        else
            c = 0
            ip=11; ip = 2     # GOTO C
            step = 2
            next
        end
        ip=12; b += 1
        ip=13; c = (b > e) ? 1 : 0
        if c == 0
            ip=15; ip = 1       # GOTO F
            step = 1
            next
        else
            ip=16; ip = ip * ip
            break
        end
    else
        start = 0
    end

    ip=17; e = e + 2 # B
    ip=18; e = e * e
    ip=19; e = ip * e
    ip=20; e = e * 11
    ip=21; c = c + 1
    ip=22; c = c * ip
    ip=23; c = c + 6
    ip=24; e = e + c
    p e
    ip=25; ip = ip + a # JUMP a+1
    if a == 0 #ip=26; ip = 0 # GOTO E
        step = 0
        next
    end
    ip=27; c = ip     if a <= 1
    ip=28; c = c * ip if a <= 2
    ip=29; c = ip + c if a <= 3
    ip=30; c = ip * c if a <= 4
    ip=31; c = c * 14 if a <= 5
    ip=32; c = c * ip if a <= 6
    ip=33; e = e + c  if a <= 7
    ip=34; a = 0      if a <= 8
    p e
    break             if a > 8
        
    #ip=35; ip = 0 # GOTO E
end

p [a,b,c,d,ip,e]