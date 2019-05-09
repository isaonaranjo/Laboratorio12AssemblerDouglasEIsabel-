@ Maria Isabel Ortiz Naranjo
 @ Douglas de Leon 
 @ carnet: 18037
@ Carnet: 18176
@ 6/05/2019

.text
.align 2
.global main

main:
	bl GetGpioAddress

	mov r0, #16
	mov r1, #1
	bl SetGpioFunction

	mov r0, #17
	mov r1, #1
	bl SetGpioFunction

	mov r0, #22
	mov r1, #1
	bl SetGpioFunction

	mov r0, #16
	mov r1, #0
	bl SetGpio

	mov r0, #17
	mov r1, #0
	bl SetGpio

	mov r0, #22
	mov r1, #0
	bl SetGpio

	bl wait

ingreso:
	ldr r0, =mensajeIngreso
	bl puts

	ldr r0, =formato
	ldr r1, =numero
	bl scanf

	ldr r1, =numero
	ldr r1, [r1]

	cmp r1, #0
	cmpge r1, #7
	ldrgt r0, =mensaje1
	blgt puts
	blle encenderLeds

	b final

final:
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}
	bx lr

encenderLeds:
	push {lr}
	ldr r1, =numero
	ldrb r1, [r1]

	cmp r1, #0
	beq cero

	cmp r1, #1
	beq uno

	cmp r1, #2
	beq dos

	cmp r1, #3
	beq tres

	cmp r1, #4
	beq cuatro

	cmp r1, #5
	beq cinco

	cmp r1, #6
	beq seis

	cmp r1, #7
	beq siete

cero:
	mov r0, #16
	mov r1, #0
	bl SetGpio

	mov r0, #17
	mov r1, #0
	bl SetGpio

	mov r0, #22
	mov r1, #0
	bl SetGpio

	bl wait
	b fin

uno:
	mov r0, #16
	mov r1, #0
	bl SetGpio

	mov r0, #17
	mov r1, #0
	bl SetGpio

	mov r0, #22
	mov r1, #1
	bl SetGpio

	bl wait
	b fin

dos:
	mov r0, #16
	mov r1, #0
	bl SetGpio

	mov r0, #17
	mov r1, #1
	bl SetGpio

	mov r0, #22
	mov r1, #0
	bl SetGpio

	bl wait
	b fin

tres:
	mov r0, #16
	mov r1, #0
	bl SetGpio

	mov r0, #17
	mov r1, #1
	bl SetGpio

	mov r0, #22
	mov r1, #1
	bl SetGpio

	bl wait
	b fin

cuatro:
	mov r0, #16
	mov r1, #1
	bl SetGpio

	mov r0, #17
	mov r1, #0
	bl SetGpio

	mov r0, #22
	mov r1, #0
	bl SetGpio

	bl wait
	b fin

cinco:
	mov r0, #16
	mov r1, #1
	bl SetGpio

	mov r0, #17
	mov r1, #0
	bl SetGpio

	mov r0, #22
	mov r1, #1
	bl SetGpio

	bl wait
	b fin

seis:
	mov r0, #16
	mov r1, #1
	bl SetGpio

	mov r0, #17
	mov r1, #1
	bl SetGpio

	mov r0, #22
	mov r1, #0
	bl SetGpio

	bl wait
	b fin

siete:
	mov r0, #16
	mov r1, #1
	bl SetGpio

	mov r0, #17
	mov r1, #1
	bl SetGpio

	mov r0, #22
	mov r1, #1
	bl SetGpio

	bl wait
	b fin

fin:
	pop {pc}

wait:
	mov r0, #0x4000000

sleepLoop:
	subs r0, #1
	bne sleepLoop
	mov pc, lr

.data
.align 2
.global myloc
myloc: .word 0
mensajeIngreso:
	.asciz	"Ingrese un numero entre 0 y 7"

numero:
	.word 0

formato:
	.asciz "%d"

mensaje1:
	.asciz "El numero no esta en el rango"
	.end
