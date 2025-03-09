.586
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern malloc: proc
extern memset: proc
extern printf: proc 

includelib canvas.lib
extern BeginDrawing: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;aici declaram date
window_title DB "Battleship",0
area_width EQU 1400
area_height EQU 700
area DD 0

col EQU 10
lin EQU 10
board_size equ 500 
board_x equ 100
board_y equ 100

board2_x equ 700
board2_y equ 100

ship2 EQU 2
ship3 EQU 3
ship4 EQU 4
ship5 EQU 5

nord_disp dd 0
sud_disp dd 0
est_disp dd 0
vest_disp dd 0
indice dd 0
catul dd 0
directie dd 0


photo EQU 0

counter DD 0 ; numara evenimentele de tip timer
scor DD 0
ratari DD 0
vap_nedesc DD 17

scor2 DD 0
ratari2 DD 0
vap_nedesc2 DD 17

arg1 EQU 8
arg2 EQU 12
arg3 EQU 16
arg4 EQU 20

symbol_width EQU 10
symbol_height EQU 20


image_width_water EQU 50; 48
image_height_water EQU 50

image_width_ship EQU 48
image_height_ship EQU 48

include water.inc
include ship.inc
include digits.inc
include letters.inc

button_x EQU 500
button_y EQU 150
button_size EQU 50

x dd 0
y dd 0

m_barci db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0 
   
m_barci2 db 0,0,0,0,0,0,0,0,0,0
		 db 0,0,0,0,0,0,0,0,0,0
		 db 0,0,0,0,0,0,0,0,0,0
		 db 0,0,0,0,0,0,0,0,0,0
	 	 db 0,0,0,0,0,0,0,0,0,0
	  	 db 0,0,0,0,0,0,0,0,0,0
		 db 0,0,0,0,0,0,0,0,0,0
		 db 0,0,0,0,0,0,0,0,0,0
		 db 0,0,0,0,0,0,0,0,0,0
		 db 0,0,0,0,0,0,0,0,0,0
   
m_aruncari db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0 
   
m_aruncari2 db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0
   db 0,0,0,0,0,0,0,0,0,0 
   
PLAYER DB 1
   
format db "%d" , 0
.code




place_ship macro ship, m_barci
local again, next, gata
local nord_loop , sud_loop, est_loop, vest_loop
local loop_plasare_barca_nord, loop_plasare_barca_sud, loop_plasare_barca_est, loop_plasare_barca_vest
local est, vest
		rdtsc
		shl eax, 26
		shr eax, 30
		mov directie, eax
again:
	;mov nord_disp , 1
	;mov sud_disp , 1
	;mov est_disp, 1
	;mov vest_disp , 1
	rdtsc ;edx:eax val
	
	
	mov ecx, 100
	mov edx, 0
	div ecx 
	
	
	; in edx este coord noastra
	cmp m_barci[edx], 1
	je again
		; mov m_barci[edx],1
		mov indice,edx
		
		
		
		mov ecx, ship
		
		;se genereaza directia care o sa fie de la 0 la 3
		;0 - n , 1- s, 2- e, 3- v
		
		cmp directie, 0
		jne sud_loop
		nord_loop:
		    sub edx, 10
			cmp edx, 0	;am iesit din matrice
			jl next
		    cmp m_barci[edx], 1
			je next ;daca zona e ocupata
			
			loop nord_loop
			mov ecx, ship
			
			loop_plasare_barca_nord:
			mov m_barci[edx], 1
			add edx, 10
			loop loop_plasare_barca_nord
			jmp gata
			next:
			mov ecx, ship
			
		
		 sud_loop:
			cmp directie, 1
			jne est
			add edx, 10
			cmp edx, 99
			jg again
			cmp m_barci[edx],1
			je again
			loop sud_loop
			mov ecx, ship
			
			loop_plasare_barca_sud:
			mov m_barci[edx],1
			sub edx, 10
			loop loop_plasare_barca_sud
			jmp gata
			
		est:
		cmp directie, 2
		jne vest
			mov esi, edx ;modificam edx cu esi pt claritate
			mov eax, esi
			mov ebx, 10
			mov edx, 0
			div ebx     ;in eax avem catul
			mov catul, eax   ;stocam in var catul , catul din eax 
			
			est_loop:
			add esi,1
			mov eax, esi
			mov ebx, 10
			mov edx, 0
			div ebx     ; in eax avem catul urmatoarei pozitii
			
			cmp catul, eax
			jne again
			
			cmp m_barci[esi],1
			je again
			loop est_loop
		
			mov esi, indice
			mov ecx, ship
			loop_plasare_barca_est:
			mov m_barci[esi],1
			add esi, 1
			loop loop_plasare_barca_est
			jmp gata
		vest:
			mov esi, edx ;modificam edx cu esi pt claritate
			mov eax, esi
			mov ebx, 10
			mov edx, 0
			div ebx     ;in eax avem catul
			mov catul, eax   ;stocam in var catul , catul din eax 
			
			vest_loop:
			sub esi,1
			mov eax, esi
			mov ebx, 10
			mov edx, 0
			div ebx     ; in eax avem catul urmatoarei pozitii
			
			cmp catul, eax
			jne again
			
			cmp m_barci[esi],1
			je again
			loop vest_loop
		
			mov esi, indice
			mov ecx, ship
			loop_plasare_barca_vest:
			mov m_barci[esi],1
			sub esi, 1
			loop loop_plasare_barca_vest
	gata:
endm
; procedura make_text afiseaza o litera sau o cifra la coordonatele date
; arg1 - simbolul de afisat (litera sau cifra)
; arg2 - pointer la vectorul de pixeli
; arg3 - pos_x
; arg4 - pos_y

make_text proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1] ; citim simbolul de afisat
	cmp eax, 'A'
	jl make_digit
	cmp eax, 'Z'
	jg make_digit
	sub eax, 'A'
	lea esi, letters
	jmp draw_text
make_digit:
	cmp eax, '0'
	jl make_space
	cmp eax, '9'
	jg make_space
	sub eax, '0'
	lea esi, digits
	jmp draw_text
make_space:	
	mov eax, 26 ; de la 0 pana la 25 sunt litere, 26 e space
	lea esi, letters
	
draw_text:
	mov ebx, symbol_width
	mul ebx
	mov ebx, symbol_height
	mul ebx
	add esi, eax
	mov ecx, symbol_height
bucla_simbol_linii:
	mov edi, [ebp+arg2] ; pointer la matricea de pixeli
	mov eax, [ebp+arg4] ; pointer la coord y
	add eax, symbol_height
	sub eax, ecx
	mov ebx, area_width
	mul ebx
	add eax, [ebp+arg3] ; pointer la coord x
	shl eax, 2 ; inmultim cu 4, avem un DWORD per pixel
	add edi, eax
	push ecx
	mov ecx, symbol_width
bucla_simbol_coloane:
	cmp byte ptr [esi], 0
	je simbol_pixel_alb
	mov dword ptr [edi], 0
	jmp simbol_pixel_next
simbol_pixel_alb:
	mov dword ptr [edi], 0FFFFFFh
simbol_pixel_next:
	inc esi
	add edi, 4
	loop bucla_simbol_coloane
	pop ecx
	loop bucla_simbol_linii
	popa
	mov esp, ebp
	pop ebp
	ret
make_text endp

; un macro ca sa apelam mai usor desenarea simbolului
make_text_macro macro symbol, drawArea, x, y
	push y
	push x
	push drawArea
	push symbol
	call make_text
	add esp, 16
endm


draw_linie_orizontal macro x, y, len, color
	local bucla_linie
	mov eax, y 
	mov ebx, area_width
	mul ebx 
	add eax, x
	shl eax, 2
	add eax, area
	
	mov ecx, len
	bucla_linie:
	mov dword ptr[eax], color
	add eax, 4
	loop bucla_linie
endm

draw_linie_vertical macro x, y, len, color
	local bucla_linie
	mov eax, y 
	mov ebx, area_width
	mul ebx 
	add eax, x
	shl eax, 2
	add eax, area
	mov ecx, len
	bucla_linie:
	mov dword ptr[eax], color
	add eax, area_width*4
	loop bucla_linie
endm

actualizare_coordonate macro x
local sari_0
local sari_50
local final
	mov eax, x
	mov edx, 0
	mov ecx, 100
	div ecx
	
	cmp edx, 50
	jl sari_0
	cmp edx, 50
	jg sari_50
	
		
	sari_0:
		mov eax, x
		;mov ecx, 100
		mov edx, 0
		div ecx
		mul ecx
	jmp final
	
	sari_50:
		mov eax, x
		;mov ecx, 100
		mov edx, 0
		div ecx
		mul ecx
		add eax, 50
	jmp final
	
	final:
	mov x, eax
	
endm

coordonate_to_indici_1 macro x
	local final
	sub x, 100
	mov eax, x
	mov ecx, 50
	mov edx, 0
	div ecx
	jmp final
	
	final:
	mov x, eax
endm

coordonate_to_indici_2 macro x
	local final
	sub x, 700
	mov eax, x
	mov ecx, 50
	mov edx, 0
	div ecx
	jmp final
	
	final:
	mov x, eax
endm


;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! desen apa si ship
make_image_water proc 
	push ebp
	mov ebp, esp
	pusha
	lea esi, var_0
	
draw_image:
	mov ecx, image_height_water
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height_water
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width_water ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_image_water endp

make_image_ship proc 
	push ebp
	mov ebp, esp
	pusha
	lea esi, ship_0
	
draw_image:
	mov ecx, image_height_ship
loop_draw_lines:
	mov edi, [ebp+arg1] ; pointer to pixel area
	mov eax, [ebp+arg3] ; pointer to coordinate y
	
	add eax, image_height_ship 
	sub eax, ecx ; current line to draw (total - ecx)
	
	mov ebx, area_width
	mul ebx	; get to current line
	
	add eax, [ebp+arg2] ; get to coordinate x in current line
	shl eax, 2 ; multiply by 4 (DWORD per pixel)
	add edi, eax
	
	push ecx
	mov ecx, image_width_ship ; store drawing width for drawing loop
	
loop_draw_columns:

	push eax
	mov eax, dword ptr[esi] 
	mov dword ptr [edi], eax ; take data from variable to canvas
	pop eax
	
	add esi, 4
	add edi, 4 ; next dword (4 Bytes)
	
	loop loop_draw_columns
	
	pop ecx
	loop loop_draw_lines
	popa
	
	mov esp, ebp
	pop ebp
	ret
make_image_ship endp

; simple macro to call the procedure easier
make_image_macro_water macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_image_water
	add esp, 12
endm
make_image_macro_ship macro drawArea, x, y
	push y
	push x
	push drawArea
	call make_image_ship
	add esp, 12
endm
;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1 end desen ship si water
; functia de desenare - se apeleaza la fiecare click
; sau la fiecare interval de 200ms in care nu s-a dat click
; arg1 - evt (0 - initializare, 1 - click, 2 - s-a scurs intervalul fara click)
; arg2 - x
; arg3 - y
draw proc
	push ebp
	mov ebp, esp
	pusha
	
	mov eax, [ebp+arg1]
	cmp eax, 1
	jz evt_click
	cmp eax, 2
	jz evt_timer ; nu s-a efectuat click pe nimic
	;mai jos e codul care intializeaza fereastra cu pixeli albi
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	push 255
	push area
	call memset
	add esp, 12
	
    place_ship ship2, m_barci
	place_ship ship3, m_barci
	place_ship ship3, m_barci
	place_ship ship4, m_barci
	place_ship ship5, m_barci
	
	place_ship ship2, m_barci2
	place_ship ship3, m_barci2
	place_ship ship3, m_barci2
	place_ship ship4, m_barci2
	place_ship ship5, m_barci2
	
	make_text_macro '1', area, 720, 610
	
	jmp afisare_litere
	
evt_click:
	
	mov AL, PLAYER
	cmp AL, 1 ;;PLAYER 1
	jne randul_la_juc_2
	
	

	mov eax, [ebp+arg2]
	cmp eax, board_x
	jl board_fail
	
	cmp eax, board_x+board_size-2
	jg board_fail
	
	mov eax, [ebp+arg3]
	cmp eax, board_y
	jl board_fail
	
	cmp eax, board_y+board_size-2
	jg board_fail
	 ;inseamna ca suntem inauntru la board1
	;make_text_macro '1', area, 650,650

	actualizare_coordonate [ebp+arg2]
	actualizare_coordonate [ebp+arg3] 
	; se actualizeaza x si y cu coltul, aici se afla multiplu de 10 (300, 350, etc)
	; acum trb sa iau aceste coordonate si sa le fac sa pointeze la valoare din matrice
	; prima data img
	
	mov ebx, dword ptr[ebp+arg2]
	mov x, ebx 
	mov ebx, dword ptr[ebp+arg3]
	mov y, ebx
	
	coordonate_to_indici_1 dword ptr[ebp+arg2]    ;x, ca in c
	coordonate_to_indici_1 dword ptr[ebp+arg3]	;y, ca in c
	
	;make_image_macro_water area,x , y
	
	mov eax, dword ptr[ebp+arg3]   ; eax=y
	mov edx, 0
	mov ecx, 10
	mul ecx
	mov ebx, dword ptr[ebp+arg2]   ; ebx=x
	
	cmp m_barci[ebx][eax], 1
	jne este_apa
		make_image_macro_ship area,x , y
		cmp m_aruncari[eax][ebx], 1
		je nu_incrementam_1
		mov PLAYER, 2
	make_text_macro '2', area, 720, 610
		mov  m_aruncari[eax][ebx], 1
		inc scor
		dec vap_nedesc
		nu_incrementam_1:
	    jmp board_fail
	este_apa:
	    make_image_macro_water area,x , y
		cmp m_aruncari[eax][ebx], 1
		je nu_incrementam_2
		mov PLAYER, 2
	make_text_macro '2', area, 720, 610
		mov  m_aruncari[eax][ebx], 1
		inc ratari
		
		nu_incrementam_2:
	jmp board_fail
	
	;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!board2
	randul_la_juc_2:

	
	check_other_board:
	mov eax, [ebp+arg2]
	cmp eax, board2_x
	jl board_fail
	
	cmp eax, board2_x+board_size-2
	jg board_fail
	
	mov eax, [ebp+arg3]
	cmp eax, board2_y
	jl board_fail
	
	cmp eax, board2_y+board_size-2
	jg board_fail
	;inseamna ca suntem inauntru la board2
	;make_text_macro '1', area, 650,650

	
	
	
	actualizare_coordonate [ebp+arg2]
	actualizare_coordonate [ebp+arg3] 
	mov ebx, dword ptr[ebp+arg2]
	mov x, ebx 
	mov ebx, dword ptr[ebp+arg3]
	mov y, ebx
	
	coordonate_to_indici_2 dword ptr[ebp+arg2]    ;x, ca in c
	coordonate_to_indici_1 dword ptr[ebp+arg3]	;y, ca in c
	
	;make_image_macro_water area,x , y
	
	mov eax, dword ptr[ebp+arg3]   ; eax=y
	mov edx, 0
	mov ecx, 10
	mul ecx
	mov ebx, dword ptr[ebp+arg2]   ; ebx=x
	
	cmp m_barci2[ebx][eax], 1
	jne este_apa_2
		make_image_macro_ship area,x , y
		cmp m_aruncari2[eax][ebx], 1
		je nu_incrementam_3
		mov PLAYER, 1
	make_text_macro '1', area, 720, 610
		mov  m_aruncari2[eax][ebx], 1
		inc scor2
		dec vap_nedesc2
		nu_incrementam_3:
	    jmp board_fail
	este_apa_2:
	    make_image_macro_water area,x , y
		
		cmp m_aruncari2[eax][ebx], 1
		je nu_incrementam_4
		mov PLAYER, 1
	make_text_macro '1', area, 720, 610
		mov  m_aruncari2[eax][ebx], 1
		inc ratari2
		
		nu_incrementam_4:
	jmp board_fail
	
	
	
	
	
	
	board_fail:
		;push scor
		; push offset format
		; call printf
		; add ESP, 12
		; ptr mine, sa vad cat e scorul dupa fiecare click
		
		mov eax, scor
		cmp eax, 17
		jl vezi_jucator_2

			make_text_macro 'C', area, 600, 650
			make_text_macro 'A', area, 610, 650
			make_text_macro 'S', area, 620, 650
			make_text_macro 'T', area, 630, 650
			make_text_macro 'I', area, 640, 650
			make_text_macro 'G', area, 650, 650
			make_text_macro 'A', area, 660, 650
			make_text_macro 'T', area, 670, 650
			make_text_macro 'O', area, 680, 650
			make_text_macro 'R', area, 690, 650
			
			
			make_text_macro '1', area, 710, 650
	
	vezi_jucator_2:
	mov eax, scor2
		cmp eax, 17
		jl continua_jocul
			make_text_macro 'C', area, 600, 660
			make_text_macro 'A', area, 610, 660
			make_text_macro 'S', area, 620, 660
			make_text_macro 'T', area, 630, 660
			make_text_macro 'I', area, 640, 660
			make_text_macro 'G', area, 650, 660
			make_text_macro 'A', area, 660, 660
			make_text_macro 'T', area, 670, 660
			make_text_macro 'O', area, 680, 660
			make_text_macro 'R', area, 690, 660
			
			
			make_text_macro '2', area, 710, 660
		
		
	continua_jocul:
	
	
evt_timer:
	inc counter

make_board_macro macro  board_x, board_y
	draw_linie_orizontal board_x, board_y, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*2, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*3, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*4, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*5, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*6, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*7, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*8, board_size, 0
	draw_linie_orizontal board_x, board_y+button_size*9, board_size, 0
	draw_linie_orizontal board_x, board_y+board_size, board_size, 0
	
	draw_linie_vertical board_x, board_y, board_size, 0
	draw_linie_vertical board_x+button_size, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*2, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*3, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*4, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*5, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*6, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*7, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*8, board_y, board_size, 0
	draw_linie_vertical board_x+button_size*9, board_y, board_size, 0
	draw_linie_vertical board_x+board_size, board_y, board_size, 0
	
	
	make_text_macro 'A', area, board_x+20 , 70
	make_text_macro 'B', area, board_x+20+button_size , 70
	make_text_macro 'C', area, board_x+20+button_size*2 , 70
	make_text_macro 'D', area, board_x+20+button_size*3 , 70
	make_text_macro 'E', area, board_x+20+button_size*4 , 70
	make_text_macro 'F', area, board_x+20+button_size*5 , 70
	make_text_macro 'G', area, board_x+20+button_size*6 , 70
	make_text_macro 'H', area, board_x+20+button_size*7 , 70
	make_text_macro 'I', area, board_x+20+button_size*8 , 70
	make_text_macro 'J', area, board_x+20+button_size*9 , 70
	
	
	make_text_macro '1', area, board_x-20, 115
	make_text_macro '2', area, board_x-20, 115+button_size
	make_text_macro '3', area, board_x-20, 115+button_size*2
	make_text_macro '4', area, board_x-20, 115+button_size*3
	make_text_macro '5', area, board_x-20, 115+button_size*4
	make_text_macro '6', area, board_x-20, 115+button_size*5
	make_text_macro '7', area, board_x-20, 115+button_size*6
	make_text_macro '8', area, board_x-20, 115+button_size*7
	make_text_macro '9', area, board_x-20, 115+button_size*8
	make_text_macro '1', area, board_x-30, 115+button_size*9
	make_text_macro '0', area, board_x-20, 115+button_size*9

endm

afisare_litere:

	make_text_macro 'S', area, 50, 650
	make_text_macro 'O', area, 60, 650
	make_text_macro 'R', area, 70, 650
	make_text_macro 'A', area, 80, 650
	make_text_macro 'N', area, 90, 650
	make_text_macro 'A', area, 100, 650
	make_text_macro 'G', area, 120, 650
	make_text_macro 'H', area, 130, 650
	make_text_macro 'I', area, 140, 650
	make_text_macro 'O', area, 150, 650
	make_text_macro 'R', area, 160, 650
	make_text_macro 'G', area, 170, 650
	make_text_macro 'H', area, 180, 650
	make_text_macro 'E', area, 190, 650
	; TEXT JUCATOR 1
	make_text_macro 'J', area, 150 , 10
	make_text_macro '1', area, 160 , 10
	
	make_text_macro 'L', area, 180 , 10
	make_text_macro 'O', area, 190 , 10
	make_text_macro 'V', area, 200 , 10
	make_text_macro 'I', area, 210 , 10
	make_text_macro 'T', area, 220 , 10
	make_text_macro 'U', area, 230 , 10
	make_text_macro 'R', area, 240 , 10
	make_text_macro 'I', area, 250 , 10
	
	mov ebx, 10
	mov eax, scor
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 280, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 270, 10

	make_text_macro 'R', area, 300 , 10
	make_text_macro 'A', area, 310 , 10
	make_text_macro 'T', area, 320 , 10
	make_text_macro 'A', area, 330 , 10
	make_text_macro 'R', area, 340 , 10
	make_text_macro 'I', area, 350 , 10
	
	mov ebx, 10
	mov eax, ratari
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 380, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 370, 10
	
	make_text_macro 'R', area, 400 , 10
	make_text_macro 'A', area, 410 , 10
	make_text_macro 'M', area, 420 , 10
	make_text_macro 'A', area, 430 , 10
	make_text_macro 'S', area, 440 , 10
	make_text_macro 'E', area, 450 , 10
	
	mov ebx, 10
	mov eax, vap_nedesc
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 480, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 470, 10
	; TEXT JUCATOR 2
	
	make_text_macro 'J', area, 750 , 10
	make_text_macro '2', area, 760 , 10
	
	make_text_macro 'L', area, 780 , 10
	make_text_macro 'O', area, 790 , 10
	make_text_macro 'V', area, 800 , 10
	make_text_macro 'I', area, 810 , 10
	make_text_macro 'T', area, 820 , 10
	make_text_macro 'U', area, 830 , 10
	make_text_macro 'R', area, 840 , 10
	make_text_macro 'I', area, 850 , 10
	
	mov ebx, 10
	mov eax, scor2
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 880, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 870, 10

	make_text_macro 'R', area, 900 , 10
	make_text_macro 'A', area, 910 , 10
	make_text_macro 'T', area, 920 , 10
	make_text_macro 'A', area, 930 , 10
	make_text_macro 'R', area, 940 , 10
	make_text_macro 'I', area, 950 , 10
	
	mov ebx, 10
	mov eax, ratari2
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 980, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 970, 10
	
	make_text_macro 'R', area, 1000 , 10
	make_text_macro 'A', area, 1010 , 10
	make_text_macro 'M', area, 1020 , 10
	make_text_macro 'A', area, 1030 , 10
	make_text_macro 'S', area, 1040 , 10
	make_text_macro 'E', area, 1050 , 10
	
	mov ebx, 10
	mov eax, vap_nedesc2
	;cifra unitatilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 1080, 10
	;cifra zecilor
	mov edx, 0
	div ebx
	add edx, '0'
	make_text_macro edx, area, 1070, 10
	
	
	;BOARD JUCATOR 1
	make_board_macro board_x, board_y
	
	;BOARD JUCATOR 2 
	make_board_macro board2_x, board2_y
	
	make_text_macro 'R', area, 590, 610
	make_text_macro 'A', area, 600, 610
	make_text_macro 'N', area, 610, 610
	make_text_macro 'D', area, 620, 610
	
	make_text_macro 'J', area, 640, 610
	make_text_macro 'U', area, 650, 610
	make_text_macro 'C', area, 660, 610
	make_text_macro 'A', area, 670, 610
	make_text_macro 'T', area, 680, 610
	make_text_macro 'O', area, 690, 610
	make_text_macro 'R', area, 700, 610
	

	
	
final_draw:
	popa
	mov esp, ebp
	pop ebp
	ret
draw endp

start:
	;alocam memorie pentru zona de desenat
	mov eax, area_width
	mov ebx, area_height
	mul ebx
	shl eax, 2
	push eax
	call malloc
	add esp, 4
	mov area, eax
	;apelam functia de desenare a ferestrei
	; typedef void (*DrawFunc)(int evt, int x, int y);
	; void __cdecl BeginDrawing(const char *title, int width, int height, unsigned int *area, DrawFunc draw);
	push offset draw
	push area
	push area_height
	push area_width
	push offset window_title
	call BeginDrawing
	add esp, 20
	;terminarea programului
	push 0
	call exit
end start
