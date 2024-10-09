.data
num_test:   .word 12
test:       .word -1,0,1,2147483647,-2147483648,48763,54321,123456789,16,256,65536,65535
answer:     .word 0,32,31,1,0,16,16,5,27,23,15,16    
statement1: .string "All Test Pass"
statement2: .string "Wrong, Check Again"
.text
main:
    la t0, num_test
    lw a0, 0(t0)   # a0 = num_test
    la t1, test
    la t3, answer   
    li s0, 0x00010000 
    li s1, 0x01000000
    li s2, 0x10000000  
    li s3, 0x55af
count:
    lw a1, 0(t1)   # a1 = number
    lw a2, 0(t3)   # a2 = answer
    li t2, 0       # t2 = count
    sltu t4, a1, s0
    slli t4, t4, 4
    add t2, t2, t4
    sll a1, a1, t4
    sltu t4, a1, s1
    slli t4, t4, 3
    add t2, t2, t4
    sll a1, a1, t4
    sltu t4, a1, s2
    slli t4, t4, 2
    add t2, t2, t4
    sll a1, a1, t4
    srli t4, a1, 27
    andi t4, t4, 0x1e
    srl t4, s3, t4
    andi t4, t4, 3
    add t2, t2, t4
    sltiu t4, a1, 1
    add t2, t2, t4
next:
    bne t2, a2, wrong 
    addi t3, t3, 4
    addi t1, t1, 4
    addi a0, a0, -1
    bne a0, x0, count
return:
    la a0, statement1
    addi a7, zero, 4
    ecall  
    j fin
wrong:
    la a0, statement2
    addi a7, zero, 4
    ecall
fin:
    li a7, 10   
    ecall