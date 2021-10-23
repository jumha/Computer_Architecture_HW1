.data
arr: .word 1, 5, 9, 7, 1, 7, 6, 10, 4 # input matrix
str:    .string "The diagonal sum of this matrix is "
rowsize: .word 3 
colsize: .word 3
      
.text 
main:
    addi  sp, sp, -16
    sw    ra, 0(sp)
    la    a0, arr
    lw    a1, rowsize
    lw    a2, colsize    
    sw    a0, 4(sp)     # *mat
    addi  t0, a0, 12
    sw    t0, 8(sp)     # (* + 1)mat
    addi  t0, a0, 24
    sw    t0, 12(sp)    # (* + 2)mat
    addi  a0, sp, 4 
    jal   ra, diagonalSum 
    jal   ra, print
    lw    ra, 0(sp)
    addi  sp, sp, 16
    li    a7, 10        # end
    ecall
 
diagonalSum:
    addi  sp, sp, -8
    sw    s0, 0(sp)
    sw    s1, 4(sp)
    add   s1, zero, zero # sum = 0
    add   t0, zero, zero # i = 0
loop1:  
    slli  t1, t0, 2
    add   s0, t1, a0    
    lw    s0, 0(s0)  # (* + i)mat
    add   t1, s0, t1 
    lw    t1, 0(t1)  # (* + i)(* + i)mat
    sub   t2, a1, t0 
    addi  t2, t2, -1 # matSize - i - 1
    slli  t2, t2, 2
    add   t2, s0, t2
    lw    t2, 0(t2)  # (* + i)(* + matSize - i - 1)mat
    add   t1, t1, t2
    add   s1, s1, t1 # sum += mat[i][i] + mat[i][matSize - i - 1]
    addi  t0, t0, 1
    slt   t1, t0, a1
    bnez  t1, loop1
    andi  t1, a1, 1
    beqz  t1, L1
    srli  t0, a1, 1  # rowsize / 2
    slli  t0, t0, 2  
    add   s0, t0, a0
    lw    s0, 0(s0)  # (* + i)mat
    add   t0, s0, t0 
    lw    t0, 0(t0)  # (* + i)(* + i)mat
    sub   s1, s1, t0
L1:
    mv    a1, s1
    lw    s0, 0(sp)
    lw    s1, 4(sp)
    addi  sp, sp, 8
    jr    ra   
print:
    la    a0, str       # load string
    li    a7, 4         # print string
    ecall
    mv    a0, a1        # load sum
    li    a7, 1         # print integer
    ecall
    jr    ra 