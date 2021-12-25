org 100h

.data
    j DW 23
    m DW 11
    a DW 2021
    m1 DW ?
    a1 DW ?
    ns DW 20 
    as DW 21
    f DW ?
    
    four DW 4
    two DW 2
    ts DW 26 
    ten DW 10 
    seven DW 07  
    hun DW 100   
    
    mod DW ?
    
    
.code 

;MOV AX,a
;;DIV hun
;MOV ns,AX
;MOV as,DX


MOV AX, m
MOV BX, a

CMP m,3
JGE m_ge
JL m_l
 

ff:
MOV BX, 0
MOV CX, 0

ADD CX, j

ADD CX, as

MOV AX, as
DIV four
ADD CX, AX

MOV AX, ns
MUL two
SUB CX, AX

MOV AX, ns
DIV four
ADD CX, AX 

MOV AX, m1
MUL ts
SUB AX, 2
DIV ten

ADD CX, AX

MOV f,CX 
MOV AX, CX
DIV seven
MOV mod,DX


ret

m_ge:
    SUB AX, 2
    MOV m1, AX
    MOV a1, BX 
    JMP ff
    
m_l:
    ADD AX, 10
    SUB BX, 1
    MOV m1, AX
    MOV a1, BX
    JMP ff









