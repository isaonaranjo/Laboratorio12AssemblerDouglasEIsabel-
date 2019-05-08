@ Maria Isabel Ortiz Naranjo
@ Carnet: 18176
@ 6/05/2019

 .text
 .align 2|
 .global main

main:
	@utilizando la biblioteca GPIO (gpio0_2.s)
	bl GetGpioAddress @solo se llama una vez
	
	@GPIO para escritura (salida) puerto 16
	mov r0,#16
	mov r1,#1
	bl SetGpioFunction

    @GPIO para escritura (salida) puerto 17
	mov r0,#17
	mov r1,#1
	bl SetGpioFunction

    @GPIO para escritura (salida) puerto 22
	mov r0,#22
	mov r1,#1
	bl SetGpioFunction

    @@ Todos los leds apagados
    @Apagar GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio

    @Apagar GPIO 17
	mov r0,#17
	mov r1,#0
	bl SetGpio

    @Apagar GPIO 22
	mov r0,#22
	mov r1,#0
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds apagados
ingreso:
    ldr r0, =mensajeIngreso 
    bl puts
    /*El numero ingresado*/
	ldr r0,=formato
	ldr r1,=numero 
	bl scanf
	/*carga el numero en r1*/
	ldr r1,=numero
	ldr r1,[r1]
	/*compara si esta en el rango */
	cmp r1,#0
	cmpge r1,#7
	ldrgt r0,=mensaje1
	blgt puts
	blle encenderLeds
    b final 


final: 
    /* salida correcta */
	mov r0, #0
	mov r3, #0
	ldmfd sp!, {lr}	/* R13 = SP */
	bx lr

@@ Subrutina encender leds
encenderLeds:
    push {lr}
    ldr r1, =numero
    ldrb r1, [r1]
    // Comparar con 0
    cmp r1, #0
    beq cero
    // Comparar con 1
    cmp r1, #1
    beq uno
    // Comparar con 2
    cmp r1, #2
    beq dos
    // Comparar con 3
    cmp r1, #3
    beq tres
    // Comparar con 4
    cmp r1, #4
    beq cuatro 
    // Comparar con 5
    cmp r1, #5
    beq cinco 
    // Comparar con 6
    cmp r1, #6
    beq seis
    // Comparar con 7
    cmp r1, #7
    beq siete 
cero:
    @@ Todos los leds apagados
    @Apagar GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio

    @Apagar GPIO 17
	mov r0,#17
	mov r1,#0
	bl SetGpio

    @Apagar GPIO 22
	mov r0,#22
	mov r1,#0
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds apagados
    b fin 
uno:
    @@ Se enciende el puerto 22
    @Apagar GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio

    @Apagar GPIO 17
	mov r0,#17
	mov r1,#0
	bl SetGpio

    @Encender GPIO 22
	mov r0,#22
	mov r1,#1
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds
    b fin 
dos:
    @Apagar GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio

    @Encender GPIO 17
	mov r0,#17
	mov r1,#1
	bl SetGpio

    @Apagar GPIO 22
	mov r0,#22
	mov r1,#0
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds 
    b fin 
tres:
    @Apagar GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio

    @Encender GPIO 17
	mov r0,#17
	mov r1,#1
	bl SetGpio

    @Apagar GPIO 22
	mov r0,#22
	mov r1,#0
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds apagados
    b fin 
cuatro:
    @Apagar GPIO 16
	mov r0,#16
	mov r1,#0
	bl SetGpio

    @Apagar GPIO 17
	mov r0,#17
	mov r1,#0
	bl SetGpio

    @Encender GPIO 22
	mov r0,#22
	mov r1,#1
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds apagados
    b fin 
cinco:
    @Encender GPIO 16
	mov r0,#16
	mov r1,#1
	bl SetGpio

    @Apagar GPIO 17
	mov r0,#17
	mov r1,#0
	bl SetGpio

    @Encender GPIO 22
	mov r0,#22
	mov r1,#1
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds 
    b fin 
seis:
    @Encender GPIO 16
	mov r0,#16
	mov r1,#1
	bl SetGpio

    @Encender GPIO 17
	mov r0,#17
	mov r1,#1
	bl SetGpio

    @Apagar GPIO 22
	mov r0,#22
	mov r1,#0
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds 
    b fin 
siete:
    @Encender GPIO 16
	mov r0,#16
	mov r1,#1
	bl SetGpio

    @Encender GPIO 17
	mov r0,#17
	mov r1,#1
	bl SetGpio

    @Encender GPIO 22
	mov r0,#22
	mov r1,#1
	bl SetGpio
    bl wait @ llamar a wait para que se aprecien los leds 
    b fin 
 fin:   
    pop {pc}




@ brief pause routine
wait:
 mov r0, #0x4000000 @ big number
sleepLoop:
 subs r0,#1
 bne sleepLoop @ loop delay
 mov pc,lr

 .data
 .align 2
.global myloc
myloc: .word 0
mensajeIngreso:
          .asciz "Ingrese un numero entero entre 0 y 7: "
numero:
          .word 0
formato:
	.asciz "%d"
mensaje1:
    .asciz "El numero no esta en el rango"
 .end