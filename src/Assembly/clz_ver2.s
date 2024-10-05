.data
num_test: .word 10
test: .word 48763,-48763,696969,12345,1,0,654,12,0x444444,0x16412
store: .word 0x20000000
    
.text
main:
    la t0, num_test
    la t1, test
    la a2, store   
    lw a0, 0(t0)   # a0 = num_test
    addi a0, a0, -1
    lw a2, 0(a2)   # a2 = store address
count:
    lw a1, 0(t1)   # a1 = number
    li t2, 0       # t2 = count     
A32:
    bne a1, x0, A16
    li t2, 32
    j next
A16:
    li t3, 0x0000FFFF   
    bltu t3, a1, A8
    addi t2, t2, 16
    slli a1, a1, 16
A8:
    li t3, 0x00FFFFFF   
    bltu t3, a1, A4
    addi t2, t2, 8
    slli a1, a1, 8
A4:
    li t3, 0x0FFFFFFF   
    bltu t3, a1, A2
    addi t2, t2, 4
    slli a1, a1, 4
A2:
    li t3, 0x3FFFFFFF   
    bltu t3, a1, A1
    addi t2, t2, 2
    slli a1, a1, 2
A1:
    li t3, 0x7FFFFFFF   
    bltu t3, a1, next
    addi t2, t2, 1
    slli a1, a1, 1
next:
    sw t2, 0(a2)
    addi a2, a2, 4
    addi t1, t1, 4
    addi a0, a0, -1
    bge a0, x0, count
return:
    li a7, 10
    ecall