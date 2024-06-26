.data
vowel:      .asciiz     "aeiou"
msg_prompt: .asciiz     "Enter string: "
msg_out:    .asciiz     "Number of vowels is: "
msg_nl:     .asciiz     "\n"
str:        .space      80
    .text
    .globl  main
main:
    li      $v0,4   #for printing a string 
    la      $a0,msg_prompt   
    syscall
    li      $v0,8  #for reading a string 
    la      $a0,str  #input is stored 
    li      $a1,80  #max ch that can be read 
    syscall

    li      $s2,0          #vowel count          
    la      $s0,str         # pointer to the string

string_loop:
    lb      $t0,0($s0)              # get string char
    addiu   $s0,$s0,1               # point to next string char
    beqz    $t0,string_done         # at end of string? if yes, fly

    la      $s1,vowel               # point to vowels

vowel_loop:
    lb      $t1,0($s1)              # get the vowel we wish to test for
    beqz    $t1,string_loop         # any more vowels? if not, fly
    addiu   $s1,$s1,1               # point to next vowel
    bne     $t0,$t1,vowel_loop      # is string char a vowel? -- if no, loop
    addi    $s2,$s2,1               # yes, increment vowel count
    j       string_loop             # do next string char

string_done:
    # print count message
    li      $v0,4           
    la      $a0,msg_out
    syscall

    # print vowel count
    li      $v0,1     #to print an integer 
    move    $a0,$s2    #move from s2 to argument for printing a0 
    syscall     

    # print a newline
    li      $v0,4      #print a string 
    la      $a0,msg_nl   
    syscall

    # exit program
    li      $v0,10
    syscall