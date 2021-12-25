include emu8086.inc  
org 100h 
.model small
.stack 100h

.data
    a1 DB 1,2,3,4,5,6, '$'
    a2 DB 3,4,5,6,7,8, '$'
    a3 DB ?, '$'
    length dw $-a3-1

.code
main proc
MOV AL, 70h
MOV AH, 25h
LEA DX, new_int
INT 21h


MOV DI, OFFSET a3
MOV BX, OFFSET a1
MOV SI, OFFSET a2
MOV AL, '1'
INT 70h 

mov ax,@data
mov ds,ax
mov si,OFFSET a3
mov cx,4  

lx:
    mov dl,[si]
    add dl,30h
    
    mov ah,02h
    int 21h
    
    mov dl,32
    mov ah,02h
    int 21h
    
    inc si
    loop lx
  mov ah,04ch
  int 21h

MOV DI, OFFSET a3
MOV BX, OFFSET a1
MOV SI, OFFSET a2
MOV AL, '2'
INT 70h

MOV DI, OFFSET a3
MOV BX, OFFSET a1
MOV SI, OFFSET a2
MOV AL, '3'
INT 70h 

            
RET

                                   


new_int:
    CMP AL, '1'
    JE inter
    CMP AL, '2'
    JE diff
    CMP AL, '3'
    JE union
    JMP LAST
    
    inter:
        PUSH DI    
        PUSH BX
        l1:
            MOV al, [BX]
            
            CMP al, '$'
            JE e1
                
            PUSH SI
            l2:
                MOV ah, [SI]
            
                CMP ah, '$'   
                JE e2
               
                CMP al, ah    
                JNE l3
                    MOV [DI], al        
                    INC DI
                    JMP e2
                l3:
                INC SI        
                JMP l2
                
            e2:
            POP SI
            INC BX
            JMP l1
            
        e1:
        MOV DI, '$'
        POP BX
        POP DI
        JMP LAST
    
    diff:
        PUSH DI    
        PUSH BX
        l4:
            MOV al, [BX]
            
            CMP al, '$'
            JE e4
                
            PUSH SI
            MOV CX, 1 
            l5:
                MOV ah, [SI]
            
                CMP ah, '$'   
                JE e5
               
                CMP al, ah    
                JNE l6
                    MOV cx, 0                
                    JMP e5
                l6:
                INC SI        
                JMP l5
                
            e5:
            CMP CX, 0
            JE l7
                MOV [DI], al        
                INC DI
                l7:
             
            POP SI 
            INC BX
            JMP l4
            
        e4:
        MOV DI, '$'
        POP BX
        POP DI
        JMP LAST
    
    union:
        outer_loop:
            
            CMP [SI], '$'
            JE es1
            
            CMP [BX], '$'
            JE es2
            
            MOV CH, [BX]
            MOV CL, [SI]
            CMP CL, CH
            
            JE un1
            
            JMP un2:
            
            un1:
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC BX
                INC DI
                JMP outer_loop
                
            
            un2:
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC DI
                MOV CH, [BX]
                MOV [DI], CH
                INC BX
                INC DI
                JMP outer_loop   
            
            es1:
                
                CMP [BX], '$'
                JMP endloop
                
                
                MOV CH, [BX]
                MOV [DI], CH
                INC BX
                INC DI
                JMP outer_loop 
                
            es2:
            
                CMP [SI], '$'
                JMP endloop
                
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC DI
                JMP outer_loop 
                    
                 
        endloop:
        MOV [DI], '$'
        JMP LAST
    
    LAST:
    IRET
main endp
end main



