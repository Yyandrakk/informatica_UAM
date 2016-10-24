# Programa Ejemplo
.data 0
num0: .word 1 # posic 0
num1: .word 2 # posic 4
num2: .word 4 # posic 8
num3: .word 8 # posic 12
num4: .word 16 # posic 16
num5: .word 32 # posic 20
num6: .word 7 # posic 24
num7: .word 0 # posic 28
num8: .word 0 # posic 32
num9: .word 0 # posic 36
num10: .word 0 # posic 40
num11: .word 0 # posic 44


.text 0
main:
  # carga num0 a num5 en los registros 9 a 14
  lw $1, 0($zero) # En r1 un 1
  lw $2, 4($zero) # En r2 un 2
  lw $3, 8($zero) # En r3 un 4
  lw $7, 24($zero) # En r7 un 7
  beq $1,$2, no_efectivo #Salto no efectivo
  add $3,$1,$2
  add $1,$2,$2
  no_efectivo:
  add $4,$3,$1# $4=7 => Bien, $4=5 =>Mal
  beq $4,$7,efectivo #Salto efectivo
  add $3,$1,$4
  add $4,$2,$1
  efectivo:
  add $5,$4,$3 # $5=10 => Bien, $4=17 =>Mal
  
  salto4:  j salto4


