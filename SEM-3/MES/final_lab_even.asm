



include emu8086.inc  

org 100h  

.data
    arr1 DB 1,2,3,4,5,6, '$'
    arr2 DB 3,4,5,6,7,8, '$'
    output DB ?, '$'  

.code
MOV AL, 70h
MOV AH, 25h
LEA DX, C_Interrupt
INT 21h


MOV DI, OFFSET output
MOV BX, OFFSET arr1
MOV SI, OFFSET arr2
MOV AL, 1
INT 70h    


mov ax,@data
mov ds,ax
mov si,OFFSET output
mov cx,12
print 'union: '
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
       
mov dx,13
  mov ah,2
  int 21h  
  mov dx,10
  mov ah,2
  int 21h

MOV DI, OFFSET output
MOV BX, OFFSET arr1
MOV SI, OFFSET arr2
MOV AL, 2
INT 70h  

mov ax,@data
mov ds,ax
mov si,OFFSET output
mov cx,4
print 'intersection: '
l1:
    mov dl,[si]
    add dl,30h
    
    mov ah,02h
    int 21h
    
    mov dl,32
    mov ah,02h
    int 21h
    
    inc si
    loop l1    
              
mov dx,13
  mov ah,2
  int 21h  
  mov dx,10
  mov ah,2
  int 21h

MOV DI, OFFSET output
MOV BX, OFFSET arr1
MOV SI, OFFSET arr2
MOV AL, 3
INT 70h   

mov ax,@data
mov ds,ax
mov si,OFFSET output
mov cx,2
print 'difference: '
l2:
    mov dl,[si]
    add dl,30h
    
    mov ah,02h
    int 21h
    
    mov dl,32
    mov ah,02h
    int 21h
    
    inc si
    loop l2
       
mov dx,13
  mov ah,2
  int 21h  
  mov dx,10
  mov ah,2
  int 21h

            
RET

                                

C_Interrupt:

    CMP AL, 1
    JE UNION 
    CMP AL, 2
    JE INTERSECTION
    CMP AL, 3
    JE DIFFERENCE 
    JMP final
    
    INTERSECTION:
        PUSH DI    
        PUSH BX
        iloop1:
            MOV al, [BX]
            
            CMP al, '$'
            JE end_iloop1
                
            PUSH SI
            iloop2:
                MOV ah, [SI]
            
                CMP ah, '$'   
                JE end_iloop2
               
                CMP al, ah    
                JNE iabsent
                    MOV [DI], al        
                    INC DI
                    JMP end_iloop2
                iabsent:
                INC SI        
                JMP iloop2
                
            end_iloop2:
            POP SI
            INC BX
            JMP iloop1
            
        end_iloop1:
        MOV DI, '$'
        POP BX
        POP DI
        JMP final
    
    DIFFERENCE:
        PUSH DI    
        PUSH BX
        dloop1:
            MOV al, [BX]
            
            CMP al, '$'
            JE end_dloop1
                
            PUSH SI
            MOV CX, 1 
            dloop2:
                MOV ah, [SI]
            
                CMP ah, '$'   
                JE end_dloop2
               
                CMP al, ah    
                JNE dabsent
                    MOV cx, 0                
                    JMP end_dloop2
                dabsent:
                INC SI        
                JMP dloop2
                
            end_dloop2:
            CMP CX, 0
            JE dignore
                MOV [DI], al        
                INC DI
                dignore:
             
            POP SI 
            INC BX
            JMP dloop1
            
        end_dloop1:
        MOV DI, '$'
        POP BX
        POP DI
        JMP final
    
    UNION:
        uloop1:
            
            CMP [SI], '$'
            JE exit_arr1
            
            CMP [BX], '$'
            JE exit_arr2
            
            MOV CH, [BX]
            MOV CL, [SI]
            CMP CL, CH
            
            JE u_add
            
            JMP u_add_all:
            
            u_add:
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC BX
                INC DI
                JMP uloop1 
                
            
            u_add_all:
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC DI
                MOV CH, [BX]
                MOV [DI], CH
                INC BX
                INC DI
                JMP uloop1     
            
            exit_arr1:
                
                CMP [BX], '$'
                JMP break
                
                
                MOV CH, [BX]
                MOV [DI], CH
                INC BX
                INC DI
                JMP uloop1  
                
            exit_arr2:
            
                CMP [SI], '$'
                JMP break
                
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC DI
                JMP uloop1  
                    
                 
        break:
        MOV [DI], '$'
        JMP final
    
    final:
    IRET

end