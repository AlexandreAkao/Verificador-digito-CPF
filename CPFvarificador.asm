org 100h

.data
    file DB "cpf.txt", 0
    msgErrorOpen DB "Erro em abrir", 24h
    msgErrorLer DB "Erro em ler arquivo", 24h
    cpfInvalido DB "CPF INVALIDO", 24h
    cpfValido DB "CPF VALIDO", 24h
    handle DW ?
        
        
.code
    mov al, 00h
    mov ah, 3Dh
    mov dx, offset file
    int 21h
    
    jc errorOpen
    
    mov handle, ax
    
    jmp sucessOpen      
 
 
               
errorOpen:
    lea dx, msgErrorOpen
    mov ah, 09h
    int 21h
    
    ret      
 
 
 
sucessOpen:
    mov ah, 3Fh
    mov bx, handle
    mov cx, 0Bh
    int 21h     
    
    jc errorRead   
    
    jmp sucessRead      
   
   
   
errorRead:
    lea dx, msgErrorLer
    mov ah, 09h
    int 21h
    
    ret  
  
  
  
sucessRead:   
    lea si, file
    mov ax, 00h
    mov bl, 0Ah
    mov cl, 09h
    mov dx, 00h



digito1:
    mov al, [si]
    sub al, 30h
    inc si
    mul bl
    dec bx
    add dx, ax
    
    loop digito1
    
    mov ax, dx
    mov bl, 0Bh
    div bl
    
    cmp ah, 00h
    je zero1
    cmp ah, 01h
    je zero1
    jmp nZero1
         
         
         
invalido:     
    lea dx, cpfInvalido
    mov ah, 09h
    int 21h
    
    ret   
     
zero1:    
    mov dl, [si]
    
    sub dl, 30h
    
    cmp dl, 00h
    je valido
    jmp invalido
           
           
           
nZero1:
    mov dl, [si]
    sub dl, 30h
    mov bl, 0Bh
    sub bl, ah           
              
    cmp dl, bl
    je valido
    jmp invalido
 
 
 
valido:        
    lea si, file
    mov ax, 00h
    mov bl, 0Bh
    mov cl, 0Ah
    mov dx, 00h    
  
  
  
digito2:

    mov al, [si]
    sub al, 30h
    inc si
    mul bl
    dec bx
    add dx, ax
    
    loop digito2
    
    mov ax, dx
    mov bl, 0Bh
    div bl
    
    cmp ah, 00h
    je zero2
    cmp ah, 01h
    je zero2
    jmp nZero2
    

zero2:
    mov dl, [si]
    sub dl, 30h
    
    cmp dl, 00h
    je validoD2
    jmp invalido
         
         
         
nZero2:
    mov dl, [si]
    sub dl, 30h
    mov bl, 0Bh
    sub bl, ah
    
    cmp dl, bl
    je validoD2
    jmp invalido

    

validoD2:
    lea dx, cpfValido
    mov ah, 09h
    int 21h
    
    
    mov ah, 3Eh
    mov bx, handle
    int 21h 
                
    ret