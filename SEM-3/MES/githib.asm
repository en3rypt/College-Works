include emu8086.inc  ; for DEFINE_PRINT_STRING

org 100h  

.data
    set1 DB 1,2,3,4,5,6,7, '$'
    set2 DB 3,4,5,6,7,8, '$'
    setResult DB ?, '$' 
    s1 DB 'Intersection Result:','$' 
     

.code

MOV AL, 90h
MOV AH, 25h
LEA DX, custom_interrupt
INT 21h
                             

MOV DI, OFFSET setResult
MOV BX, OFFSET set1
MOV SI, OFFSET set2
MOV AL, '1'
INT 90h  
        
        

mov ax,@data
mov ds,ax
mov si,OFFSET setResult
mov cx,5

print 'intersection: '

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
    

MOV DI, OFFSET setResult
MOV BX, OFFSET set1
MOV SI, OFFSET set2
MOV AL, '2'
INT 90h 

mov ax,@data
mov ds,ax
mov si,OFFSET setResult
mov cx,4

print 'difference: '

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

MOV DI, OFFSET setResult
MOV BX, OFFSET set1
MOV SI, OFFSET set2
MOV AL, '3'
INT 90h  

mov ax,@data
mov ds,ax
mov si,OFFSET setResult
mov cx,12

print 'union: '

l3:
    mov dl,[si]
    add dl,30h
    
    mov ah,02h
    int 21h
    
    mov dl,32
    mov ah,02h
    int 21h  
    
    
    
    inc si
    loop l3

mov dx,13
  mov ah,2
  int 21h  
  mov dx,10
  mov ah,2
  int 21h

            
RET

                                   

; Get input as sorted arrays if we get from user

custom_interrupt:
    ; AL - '1' for INTERSECTION
    ; AL - '2' for DIFFERENCE
    ; AL - '3' for UNION
    CMP AL, '1'
    JE SET_INTERSECTION
    CMP AL, '2'
    JE SET_DIFFERENCE
    CMP AL, '3'
    JE SET_UNION
    JMP LAST
    
    SET_INTERSECTION:
        ; BX, SI - Address of Sets terminated with '$'
        ; DI - Address of resulting set
        PUSH DI    
        PUSH BX
        set1_iteration_intersection:
            MOV al, [BX]
            
            CMP al, '$'
            JE end_set1_iteration_intersection
                
            PUSH SI
            set2_iteration_intersection:
                MOV ah, [SI]
            
                CMP ah, '$'   
                JE end_set2_iteration_intersection
               
                CMP al, ah    
                JNE not_present_in_other_intersection
                    MOV [DI], al        
                    INC DI
                    JMP end_set2_iteration_intersection
                not_present_in_other_intersection:
                INC SI        
                JMP set2_iteration_intersection
                
            end_set2_iteration_intersection:
            POP SI
            INC BX
            JMP set1_iteration_intersection
            
        end_set1_iteration_intersection:
        MOV DI, '$'
        POP BX
        POP DI
        JMP LAST
    
    SET_DIFFERENCE:
        ; BX - Address of Set 1 terminated with '$'
        ; SI - Address of Set 2 terminated with '$'
        ; DI - Address of location to place the resulting set
        PUSH DI    
        PUSH BX
        set1_iteration_difference:
            MOV al, [BX]
            
            CMP al, '$'
            JE end_set1_iteration_difference
                
            PUSH SI
            MOV CX, 1 
            set2_iteration_difference:
                MOV ah, [SI]
            
                CMP ah, '$'   
                JE end_set2_iteration_difference
               
                CMP al, ah    
                JNE not_present_in_other_difference
                    MOV cx, 0                
                    JMP end_set2_iteration_difference
                not_present_in_other_difference:
                INC SI        
                JMP set2_iteration_difference
                
            end_set2_iteration_difference:
            CMP CX, 0
            JE dont_append_difference
                ; ADDING TO RESULT
                MOV [DI], al        
                INC DI
                dont_append_difference:
             
            POP SI 
            INC BX
            JMP set1_iteration_difference
            
        end_set1_iteration_difference:
        MOV DI, '$'
        POP BX
        POP DI
        JMP LAST
    
    SET_UNION:
        ; BX, SI - Address of Sets terminated with '$'
        ; DI - Address of resulting set
        outer_loop_union:
            
            CMP [SI], '$'
            JE end_set_1
            
            CMP [BX], '$'
            JE end_set_2
            
            MOV CH, [BX]
            MOV CL, [SI]
            CMP CL, CH
            
            JE add_one_union
            
            JMP add_both_union:
            
            add_one_union:
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC BX
                INC DI
                JMP outer_loop_union
                
            
            add_both_union:
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC DI
                MOV CH, [BX]
                MOV [DI], CH
                INC BX
                INC DI
                JMP outer_loop_union    
            
            end_set_1:
                
                CMP [BX], '$'
                JMP endloop
                
                
                MOV CH, [BX]
                MOV [DI], CH
                INC BX
                INC DI
                JMP outer_loop_union 
                
            end_set_2:
            
                CMP [SI], '$'
                JMP endloop
                
                MOV CH, [SI]
                MOV [DI], CH
                INC SI
                INC DI
                JMP outer_loop_union  
                    
                 
        endloop:
        MOV [DI], '$'
        JMP LAST
    
    LAST:
    IRET

end

