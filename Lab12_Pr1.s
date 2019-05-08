//  Lab12_Pr1.s
//  Douglas De León Molina e Isabel Ortiz Naranjo

.text
.align 2
.global main

main:

@utilizando la biblioteca GPIO (gpio0.s)
bl GetGpioAddress     @solo se llama una vez

@GPIO para escritura (salida) puerto 17
mov r0,#17
mov r1,#1
bl SetGpioFunction

@GPIO para lectura (salida) puerto 22
mov r0,#22
mov r1,#1
bl SetGpioFunction

cicloIngreso:

    ldr r0,=mensaje_bienvenida
    bl puts

    ldr r0,=mensaje_entrada
    bl puts

@ lee caracter en R0, se graba en ingreso.
    ldr r0,=formatoC
    ldr r1,=ingreso
    bl scanf

    ldr r0,=debug
    bl puts

    ldr r4,=ingreso     @@dato ingresado por el usuario.

    @@ Apagar LEDs al principio del ciclo.
    mov R0,#17
    mov R1,#0
    bl SetGpio

    mov R0,#22
    mov R1,#0
    bl SetGpio

    ldr r0,=formatoC
    ldrb r1,[r4]
    bl printf

    ldr r0,=debug
    bl puts

    ldrb r5,[r4]

    @@ Si es menor que 3A podría ser un número.
    cmp r5,#0x3A        @Compara con '9'
    blt comparacionNumero

    @@ Si es menor que 5B podría ser una mayúscula.
    cmp r5,#0x5B        @Comparar con 'Z'
    blt comparacionMayuscula

    @@ Si es menor que 7B prodría ser una minúscula.
    cmp r5,#0x7B        @@Comparar con 'z'
    blt comparacionMinuscula

    bl getchar
    b nelBro


comparacionNumero:
    ldr r0,=debug_numero
    bl puts
    bl getchar

    cmp r5,#0x2F      @@Comparar con '0'
    movgt R0,#17
    movgt R1,#1
    blgt SetGpio     @@Encender LED de GPIO 17 si es mayor (es un número).
    blt nelBro
    b cicloIngreso

comparacionMayuscula:
    ldr r0,=debug_mayusculas
    bl puts
    bl getchar

    cmp R5,#0x40      @@Comparar con 'A'
    mov R0,#22
    movgt R1,#1
    movlt R1,#0
    bl SetGpio     @@Encender LED de GPIO 22 si es mayor (Es una mayúscula).
    blt nelBro
    b cicloIngreso

comparacionMinuscula:
    ldr r0,=debug_minusculas
    bl puts
    bl getchar

    cmp R5,#0x60       @@Comparar con 'a'
    mov R0,#22
    movgt R1,#1
    movlt R1,#0
    bl SetGpio     @@ Encender LED de GPIO 22 si es mayor (Es una minúscula).
    blt nelBro
    b cicloIngreso


nelBro:
    bl getchar
    ldr r0,=mensaje_error
    bl puts

    b cicloIngreso


.data
.align 2
.global myloc

    debug: .asciz "Debugeando..."

debug_numero: .asciz "Debug de números."

debug_mayusculas: .asciz "Debugeando mayusculas"

debug_minusculas: .asciz "Debugeando minusculas."

    myloc: .word 0

    mensaje_bienvenida: .asciz "Bienvenido al programa 1 del laboratorio 12. :) \n"

    mensaje_entrada: .asciz "Ingrese un caracter (0-9 o a-z/A-Z): "

    formatoC: .asciz "%c"

    mensaje_error: .asciz "El dato ingresado no está entre los rangos válidos! \n"

    ingreso: .byte ' '

.end

