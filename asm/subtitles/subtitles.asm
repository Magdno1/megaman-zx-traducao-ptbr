; Adição de legendas na rom Rockman ZX (J)
; Este é um port das rotinas presentes na rom Megaman ZX (E)
;
; Escrito por Diego Hahn - Janeiro de 2016
;
;
; PS: As rotinas estão com nomes genéricos.. Fica para uma versão futura um melhor detalhamento
;

.nds

.open "arm9_jp.bin", "arm9mod.bin", 0x02000000

.arm                                                    ; ARM code
                                    
.thumb                                                  ; THUMB code

; Será feita a alteração da rotina original que chama as subrotinas

GoToExit            equ 0x0201BF2E


.org 0x02000cc0
bl      RotinaBBB

.org 0x0201BE92             ; aqui parece ok
ldr     r0,=210422Ch
ldrb    r0,[r0,5h]
ldr     r1,[r1,4h]
bl      RotinaYYY
b       GoToExit
.pool

.org 0x0201BEDA            
bl      RotinaXXX
cmp     r0,0h
beq     GoToExit
ldr     r0,[r4,2Ch]
sub     r0,8h
str     r0,[r4,2Ch]
mov     r0,1h
add     sp,10h
pop     r4,r15
nop

.org 0x0201BEF0
bl      RotinaXXX
ldr     r2,[r4,2Ch]         ; era para usar r0, ao invés de r4.. porém r0 foi modificado pela rotina anterior
ldr     r1,[r2,4h]
cmp     r0,r1
bcs     GoToExit
sub     r2,8h
str     r2,[r4,2Ch]         ; era para usar r0, ao invés de r4.. porém r0 foi modificado pela rotina anterior
mov     r0,1h
add     sp,10h
pop     r4,r15

; Criação das subrotinas, chamadas pela principal
.org 0x0201D830
RotinaWWW:
bl      RotinaXXX
cmp     r0,r0
nop
nop
nop

.org 0x020C7790
RotinaBBB:
push    r4-r6,r14
add     sp,-38h
ldr     r0,=27E00FCh
ldr     r0,[r0]
cmp     r0,0h
bne     BBB_Jump0 
b       BBB_Jump18 
BBB_Jump0:
cmp     r0,1h
beq     BBB_Jump1 
cmp     r0,4h
bne     BBB_Jump2 
BBB_Jump1:
ldr     r0,=27E00FCh
ldr     r1,[r0]
add     r1,r1,1
str     r1,[r0]
BBB_Jump2:
ldr     r0,=27E00FCh
ldr     r0,[r0]
cmp     r0,3h
beq     BBB_Jump3 
cmp     r0,6h
bne     BBB_Jump4 
BBB_Jump3:
bl      2007198h ;;2007300h
add     sp,38h
pop     r4-r6,r15
BBB_Jump4:
mov     r0,0h
str     r0,[sp,20h]
ldr     r0,=27E027Ch
ldr     r0,[r0,8h]
blx     20BCED8h;;20BDD94h
cmp     r0,0h
bne     BBB_Jump5 
ldr     r0,=27E00FCh
ldr     r1,[r0]
add     r1,r1,1
str     r1,[r0]
add     sp,38h
pop     r4-r6,r15
BBB_Jump5:
ldr     r0,=27E027Ch
ldr     r0,[r0,8h]
blx     20BCEA0h;;20BDD5Ch
ldr     r0,=27E027Ch
ldr     r1,[r0,34h]
add     r1,r1,1
str     r1,[r0,34h]
ldr     r0,[r0,8h]
blx     20BCE04h;;20BDCC0h
str     r0,[sp,1Ch]
mov     r0,0h
str     r0,[sp,18h]
ldr     r0,[sp,1Ch]
cmp     r0,0h
bls     BBB_Jump10 
ldr     r4,=27E027Ch
ldr     r0,[sp,18h]
str     r0,[sp,34h]
str     r0,[sp,28h]
str     r0,[sp,30h]
BBB_Jump6:
ldr     r0,=27E029Ch
ldrb    r0,[r0,1Bh]
lsl     r0,r0,1Fh
lsr     r0,r0,1Fh
cmp     r0,0h
beq     BBB_Jump8 
ldr     r0,[r4,1Ch]
str     r0,[sp,24h]
ldr     r0,[r4,14h]
lsr     r0,r0,8h
str     r0,[sp,2Ch]
BBB_Jump7:
ldr     r2,[r4,20h]
ldr     r1,[r4,24h]
ldr     r0,[sp,24h]
sub     r3,r0,r2
ldr     r2,[sp,28h]
sbc     r2,r1
ldr     r0,[sp,2Ch]
sub     r5,r0,r3
ldr     r6,[sp,30h]
sbc     r6,r2
mov     r2,0h
mov     r1,r6
eor     r1,r2
mov     r0,r5
eor     r0,r2
orr     r1,r0
beq     BBB_Jump7 
BBB_Jump8:
ldr     r0,[r4,8h]
ldr     r2,[r4,0Ch]
ldr     r1,[r4,18h]
lsl     r1,r1,1h
add     r1,r2,r1
blx     20BCDCCh ;;20BDC88h
ldr     r1,[r4,0Ch]
ldr     r0,[r4,18h]
lsl     r0,r0,1h
add     r0,r1,r0
ldr     r1,=100h
blx     20A89D4h ;;20A9A00h
ldr     r1,[r4,18h]
add     r1,80h
str     r1,[r4,18h]
ldr     r0,[r4,14h]
lsr     r0,r0,1h
cmp     r1,r0
bne     BBB_Jump9 
ldr     r0,[sp,34h]
str     r0,[r4,18h]   
BBB_Jump9:
ldr     r0,[r4,1Ch]
add     r0,r0,1
str     r0,[r4,1Ch]
ldr     r0,[sp,18h]
add     r1,r0,1
str     r1,[sp,18h]
ldr     r0,[sp,1Ch]
cmp     r1,r0
bcc     BBB_Jump6 
BBB_Jump10:
ldr     r0,=27E00FCh
ldr     r0,[r0]
cmp     r0,5h
bne     BBB_Jump11
ldr     r0,=27E029Ch
ldrb    r0,[r0,1Bh]
lsl     r0,r0,1Fh
lsr     r0,r0,1Fh
cmp     r0,0h
beq     BBB_Jump11 
ldr     r1,=27E027Ch
ldr     r0,[r1,14h]
lsr     r0,r0,9h
mov     r2,0h
sub     r0,r0,r5
sbc     r2,r6
bcs     BBB_Jump11 
ldr     r0,[r1,8h]
blx     20BCE30h ;;20BDCECh
mov     r0,1h
str     r0,[sp,20h]
BBB_Jump11:
ldr     r0,[sp,20h]
cmp     r0,0h
bne     BBB_Jump4 
ldr     r1,=27E027Ch
ldr     r0,[r1,34h]
cmp     r0,4h
bcc     BBB_Jump4 
ldr     r0,=27E029Ch
ldrb    r0,[r0,1Bh]
lsl     r0,r0,1Fh
lsr     r0,r0,1Fh
cmp     r0,0h
bne     BBB_Jump12 
ldr     r0,[r1,8h]
blx     20BCF3Ch ;;20BDDF8h
mov     r1,r0
ldr     r0,=0FFB0FFh
blx     20B90E4h ;;20B9FA0h
mov     r4,r0
ldr     r0,=27E027Ch
ldr     r0,[r0,8h]
blx     20BCF3Ch ;;20BDDF8h
mov     r1,0h
str     r1,[sp]
ldr     r2,=27E027Ch
ldr     r1,[r2,14h]
lsr     r1,r1,1h
str     r1,[sp,4h]
str     r0,[sp,8h]
mov     r0,7Fh
str     r0,[sp,0Ch]
ldr     r0,=8000h
str     r0,[sp,10h]
mov     r0,40h
str     r0,[sp,14h]
ldr     r0,[r2,28h]
mov     r1,1h
ldr     r2,[r2,0Ch]
mov     r3,r1
blx     20B9F3Ch ;;20BADF8h
blx     20B9D80h ;;20BAC3Ch
ldr     r2,=27E027Ch
str     r0,[r2,2Ch]
lsl     r1,r4,2h
mov     r0,0h
str     r0,[sp]
ldr     r0,[r2,2Ch]
mov     r2,r1
ldr     r3,=2007169h;;20072D1h
blx     20AB818h ;;20AC844h
mov     r0,1h
mov     r1,0h
ldr     r2,=27E027Ch
ldr     r3,[r2,2Ch]
mov     r2,r0
lsl     r2,r3
mov     r3,r1
blx     20AB8CCh ;;20AC8F8h
mov     r0,1h
blx     20ABDC4h ;;20ACDF0h
ldr     r1,=27E029Ch
ldrb    r2,[r1,1Bh]
mov     r0,1h
bic     r2,r0
orr     r2,r0
strb    r2,[r1,1Bh]
BBB_Jump12:
ldr     r0,=27E00FCh
ldr     r0,[r0]
cmp     r0,5h
beq     BBB_Jump16 
ldr     r0,=27E029Ch
ldrb    r0,[r0,18h]
cmp     r0,0h
bne     BBB_Jump13 
ldr     r2,=27E027Ch
ldr     r4,[r2,1Ch]
mov     r0,0h
ldr     r3,[r2,20h]
ldr     r1,[r2,24h]
sub     r5,r4,r3
sbc     r0,r1
ldr     r4,[r2,10h]
mov     r1,3h
mul     r4,r1
asr     r3,r4,1Fh
sub     r1,r4,r5
sbc     r3,r0
bcc     BBB_Jump13 
ldr     r0,[r2,8h]
blx     20BCE30h ;;20BDCECh
mov     r1,1h
ldr     r0,=27E029Ch
strb    r1,[r0,18h]
b       BBB_Jump17 
BBB_Jump13:
ldr     r2,=27E029Ch
ldrb    r0,[r2,1Bh]
lsl     r0,r0,1Eh
lsr     r0,r0,1Fh
cmp     r0,0h
beq     BBB_Jump13 
ldrb    r1,[r2,1Bh]
mov     r0,2h
bic     r1,r0
strb    r1,[r2,1Bh]
BBB_Jump14:
ldrb    r1,[r2,1Ah]
ldrb    r0,[r2,19h]
cmp     r1,r0
bne     BBB_Jump14 
ldr     r0,=20F87F0h ;;20F89B0h
ldr     r4,[r0]
mov     r1,0h
str     r1,[r0]
ldr     r5,=20F8770h ;;20F8930h
lsl     r3,r1,6h
add     r3,r5,r3
str     r3,[r0,4h]
ldrb    r0,[r2,19h]
cmp     r0,0h
bne     BBB_Jump15 
mov     r1,1h
BBB_Jump15:
ldr     r0,=27E027Ch
ldr     r0,[r0,8h]
ldr     r2,=18000h
mul     r1,r2
ldr     r2,=6000000h
add     r1,r1,r2
ldr     r2,=100h
blx     20BCE68h ;; 20BDD24h ;; ?????
ldr     r1,=20F87F0h ;;20F89B0h
ldr     r3,[r1,4h]
ldr     r2,[r3]
ldr     r0,=400h
orr     r2,r0
str     r2,[r3]
str     r4,[r1]
ldr     r2,=20F8770h ;;20F8930h
lsl     r0,r4,6h
add     r0,r2,r0
str     r0,[r1,4h]
ldr     r1,=27E029Ch
ldrb    r2,[r1,19h]
mov     r0,1h
eor     r2,r0
strb    r2,[r1,19h]
ldr     r0,=27E027Ch
ldr     r2,[r0,30h]
add     r2,r2,1
str     r2,[r0,30h]
mov     r0,0h
strb    r0,[r1,18h]
b       BBB_Jump17 
BBB_Jump16:
ldr     r0,=27E027Ch
ldr     r0,[r0,8h]
blx     20BCE30h ;;20BDCECh
BBB_Jump17:
blx     20B9C58h ;;20BAB14h
BBB_Jump18:
add     sp,38h
pop     r4-r6,r15
.pool

.org 0x020c89c0
RotinaXXX:  ; ver 02007a9c.asm
push    r4,r5,r14
add     sp,-4h
ldr     r0,=27E00FCh          ; ok
ldr     r0,[r0]
cmp     r0,1h
blt     XXX_Jump2
cmp     r0,3h
bgt     XXX_Jump2
; na rom EU, ver rotina 0200882a .. ela coloca 1 nesse endereço
;;ldr     r0,=20F915Ch          ; na jp, apontar para 20F915Ch
;;ldr     r0,[r0]               ; r0 deveria ser 1
mov     r0,1h                   ; carrega o idioma
cmp     r0,0h
beq     XXX_Jump2
ldr     r0,=Ram_Ptr          ; não existe na jp (20F92F8h)
ldrb    r2,[r0]              
cmp     r2,4h
beq     XXX_Jump2
ldr     r0,=Ram_Ptr+4          ; não existe na jp (20F92FCh)
ldrb    r0,[r0]                 ; parece selecionar o tileset da legenda
lsl     r1,r0,2h
lsl     r0,r2,5h
ldr     r2,=Ram_Ptr2          ; não existe (20caeb0h)
add     r2,r2,r0
ldsh    r3,[r1,r2]
ldr     r2,=27E027Ch          ; ok
ldr     r2,[r2,30h]
cmp     r3,r2                   ; r3 contém a quantidade de frames que a legenda será mostrada
bhi     XXX_Jump2
ldr     r2,=Ram_Ptr2+2          ; não existe (20caeb2h)
add     r0,r2,r0
ldsh    r2,[r1,r0]
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
ldr     r4,[r0]
mov     r3,0h
str     r3,[r0]
ldr     r5,=20F8770h          ; na jp, apontar para 20F8770h
lsl     r1,r3,6h
add     r5,r5,r1
str     r5,[r0,4h]
cmp     r2,0h
blt     XXX_Jump0
str     r3,[sp]
mov     r0,1h
ldr     r1,=22CD008h          ; não existe
ldr     r1,[r1]
lsl     r1,r1,1h
lsr     r1,r1,1h
lsl     r2,r2,18h
lsr     r2,r2,18h
; essa rotina copia o tilemap?
bl      2005290h              ; (02005290h) verificar se essa função existe na rom jp (ok)
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
ldr     r2,[r0,4h]
ldr     r1,[r2]
ldr     r0,=100h
orr     r1,r0
str     r1,[r2]
b       XXX_Jump1
XXX_Jump0:
ldr     r1,[r5]
ldr     r0,=0FFFFFEFFh
and     r1,r0
str     r1,[r5]
XXX_Jump1:
ldr     r0,=Ram_Ptr+4          ; não existe na jp (20F92FCh)
ldrb    r1,[r0]
add     r1,r1,1
strb    r1,[r0]                ;
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
str     r4,[r0]
ldr     r2,=20F8770h          ; na jp, apontar para 20F8770h
lsl     r1,r4,6h
add     r1,r2,r1
str     r1,[r0,4h]
XXX_Jump2:
mov     r0,0h
ldr     r1,=27E00FCh          ; ok
ldr     r1,[r1]
cmp     r1,1h
blt     XXX_Jump3
cmp     r1,3h
bgt     XXX_Jump3
mov     r0,1h
XXX_Jump3:
add     sp,4h
pop     r4,r5,r15
.pool

.org  0x020c7d30
RotinaYYY:  ; ver 02007b70.asm
push    r4,r5,r14
add     sp,-14h             
ldr     r5,=20C1074h         ; na rom jp, apontar para 0x20C1074h
add     r4,sp,0h
mov     r3,10h
YYY_Jump0:                  ; nesta etapa, copia o nome do arquivo de vídeo para a stack
ldrb    r2,[r5]
add     r5,r5,1
strb    r2,[r4]
add     r4,r4,1
sub     r3,r3,1
cmp     r3,0h
bne     YYY_Jump0
mov     r3,r1
add     r3,30h
add     r2,sp,0h
strb    r3,[r2,7h]
cmp     r1,4h
bcs     YYY_Jump1
ldrb    r1,[r2,7h]
add     r0,r1,r0
strb    r0,[r2,7h]
YYY_Jump1:
bl      200784Ch              ; na rom jp, apontar para 200784Ch    
ldr     r0,=22D0000h
ldr     r1,=74000h
mov     r2,1h
mov     r3,3h
bl      2007874h              ; (2007874h) verificar se essa função existe na rom jp (ok)
add     r0,sp,0h              ; r0 aponta para o topo da stack
bl      RotinaZZZ              ; (20074A4h) verificar se essa função existe na rom jp (ok) .. mas existe coisa a mais na rotina EU
add     r0,sp,0h              ; r0 aponta para o topo da stack
ldrb    r0,[r0,7h]
sub     r0,30h
ldr     r1,=Ram_Ptr          ; não existe na jp (20F92F8h)
strb    r0,[r1]
mov     r2,0h
ldr     r0,=Ram_Ptr+4          ; não existe na jp (20F92FCh)
strb    r2,[r0]
;ldr     r0,=20F915Ch          ; na jp, apontar para 20F915Ch
;ldr     r0,[r0]               ; r0 = 01 [20f9324] - está sempre em 0  ... r0 seleciona o idioma. (1 - EN, 2 - FR ..)
mov     r0,1h
cmp     r0,0h
beq     YYY_GoToExit
ldrb    r1,[r1]               ; [20f92f8] .. r1 seleciona o arquivo de legenda
cmp     r1,4h                 
beq     YYY_GoToExit              ; se r1 == 4h , salta para saida. Os valores permitidos são 0, 1, 2, 3, 5 e 6
sub     r3,r0,1
mov     r0,1Ch
mul     r3,r0
ldr     r0,=Subtitles_PtrTable          ; ponteiro para a tabela dos arquivos da legenda .. não existe na jp
lsl     r1,r1,2h
add     r0,r0,r3
ldr     r0,[r1,r0]            ; r0 = src
ldr     r1,=22CD000h          ; r1 = dst
bl      2001E04h              ; (2001E04h) verificar se essa função existe na rom jp (ok) - lê um arquivo da rom para a ram
YYY_Jump2:
bl      2001FD4h              ; (2001FD4h) verificar se essa função existe na rom jp (ok)
cmp     r0,0h
bne     YYY_Jump2
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
ldr     r4,[r0]
mov     r1,0h
str     r1,[r0]
ldr     r3,=20F8770h          ; na jp, apontar para 20F8770h
lsl     r2,r1,6h
add     r2,r3,r2
str     r2,[r0,4h]
ldr     r0,=1F00h
strh    r0,[r2,8h]
mov     r0,1h
mov     r2,30h
bl      2004AF8h              ; (2004AF8h) verificar se essa função existe na rom jp (ok)
mov     r1,0h
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
ldr     r0,[r0,4h]
str     r1,[r0,10h]
mov     r0,1h
bl      2004954h              ; (2004954h) verificar se essa função existe na rom jp (ok)
mov     r1,r0
ldr     r0,=22CD004h
ldr     r0,[r0]
lsl     r0,r0,1h
lsr     r0,r0,1h
bl      2002A50h              ; (2002A50h) verificar se essa função existe na rom jp (ok)
ldr     r0,=22CD004h
ldr     r0,[r0]
lsl     r0,r0,1h
lsr     r0,r0,1h
add     r0,0Ch
mov     r1,0h
blx     2003B1Ch              ; na jp, apontar para 2003B1Ch verificar se essa função existe na rom jp (arm)
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
str     r4,[r0]
ldr     r2,=20F8770h          ; na jp, apontar para 20F8770h
lsl     r1,r4,6h
add     r1,r2,r1
str     r1,[r0,4h]
; saida
YYY_GoToExit:
add     sp,14h
pop     r4,r5,r15
.pool

;;.org 0x020c7a70
.org 0x020c7bd0
RotinaZZZ:  ; ver 0200760c.asm
push    r4-r6,r14
add     sp,-10h
mov     r4,r0
ldr     r0,=27E00FCh
ldr     r0,[r0]
cmp     r0,0h
beq     ZZZ_Jump0
bl      2007198h              ; na jp, apontar para 2007198h
ZZZ_Jump0:
mov     r0,0h
mvn     r0,r0
blx     20AE848h              ; na jp, apontar para 20AE848h
mov     r0,r4
bl      2007228h              ; na jp, apontar para 2007228h
cmp     r0,0h
blt     ZZZ_Jump1
mov     r1,1h
ldr     r0,=27E00FCh      
str     r1,[r0]
ldr     r1,=27E01FCh
ldr     r5,[r1,0Ch]
ldr     r4,=20F735Ch          ; na jp, apontar para 20F735Ch
mov     r3,80h
strb    r3,[r4,r5]
ldrb    r2,[r4,r5]
ldr     r0,=4000240h
strb    r2,[r5,r0]
ldr     r2,[r1,10h]
strb    r3,[r4,r2]
ldrb    r1,[r4,r2]
strb    r1,[r2,r0]
mov     r0,0h
; a partir daqui, foi acrescentado
ldr     r1,=4000Eh
bl      2002BE4h              ; na jp, apontar para 2002BE4h
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
ldr     r4,[r0]
mov     r2,0h
str     r2,[r0]
ldr     r5,=20F8770h          ; na jp, apontar para 20F8770h
lsl     r3,r2,6h
add     r1,r5,r3
str     r1,[r0,4h]
ldr     r1,[r5,r3]
mov     r6,7h
bic     r1,r6
mov     r6,5h
orr     r1,r6
str     r1,[r5,r3]
ldr     r5,[r0,4h]
ldr     r3,[r5]
ldr     r1,=0FFFFF0FFh
and     r3,r1
ldr     r1,=400h
orr     r3,r1
str     r3,[r5]
ldr     r1,=4002h
ldr     r0,[r0,4h]
strh    r1,[r0,0Ch]
mov     r0,24h
mov     r1,84h
bl      2004AF8h              ; na jp, apontar para 2004AF8h
mov     r1,0h
str     r1,[sp]
str     r1,[sp,4h]
str     r1,[sp,8h]
mov     r0,24h
ldr     r2,=100h
mov     r3,r1
bl      2004F60h              ; na jp, apontar para 2004F60h
ldr     r0,=20F87F0h          ; na jp, apontar para 20F87F0h
str     r4,[r0]
ldr     r2,=20F8770h          ; na jp, apontar para 20F8770h
lsl     r1,r4,6h
add     r1,r2,r1
str     r1,[r0,4h]
; daqui para baixo é equivalente na rom jp
bl      1FF8ECCh
mov     r0,1h
add     sp,10h
pop     r4-r6,r15
ZZZ_Jump1:
mov     r0,0h
mvn     r0,r0
blx     20AE848h              ; na jp, apontar para 20AE848h
mov     r0,0h
add     sp,10h
pop     r4-r6,r15

.pool

;;.org 0x020c7bd0
.org 0x020c8b00

; Arquivos contendo as legendas (tileset+tilemap)
.align
Subtitle_00:
.db "mm00_br.bin", 0
.align
Subtitle_01:
.db "mm01_br.bin", 0
.align
Subtitle_02:
.db "mm02_br.bin", 0
.align
Subtitle_03:
.db "mm03_br.bin", 0
.align
Subtitle_05:
.db "mm05_br.bin", 0
.align
Subtitle_06:
.db "mm06_br.bin", 0

; Tabela de ponteiros
.align
Subtitles_PtrTable:
.dw Subtitle_00 , Subtitle_01 , Subtitle_02 , Subtitle_03 , Subtitle_05 , Subtitle_06

Ram_Ptr:
.dw 0 , 0

.org 0x020c7a70
Ram_Ptr2:
.import "frames.bin"

.org 0x020e94ac
RotinaAAA:
push    r4
add     sp,-4h
ldr     r0,=27E00FCh              ; ok
ldr     r0,[r0]
cmp     r0,2h
bne     AAA_Jump2
ldr     r3,=27E029Ch              ; ok
ldrb    r1,[r3,1Ah]
ldrb    r0,[r3,19h]
cmp     r1,r0
beq     AAA_Jump2
ldrb    r0,[r3,19h]
strb    r0,[r3,1Ah]
ldrb    r0,[r3,19h]
ldr     r2,=20F87F0h              ; na jp, apontar para 20F87F0h
ldr     r1,[r2]
mov     r0,0h
str     r0,[r2]
ldr     r4,=20F8770h              ; na jp, apontar para 20F8770h
lsl     r0,r0,6h
add     r0,r4,r0
str     r0,[r2,4h]
ldrb    r2,[r3,19h]
cmp     r2,0h
beq     AAA_Jump0
ldrh    r3,[r0,0Ch]
ldr     r2,=0FFFFE0FFh
and     r3,r2
ldr     r2,=600h
orr     r3,r2
strh    r3,[r0,0Ch]
b       AAA_Jump1
AAA_Jump0:
ldrh    r3,[r0,0Ch]
ldr     r2,=0FFFFE0FFh
and     r3,r2
strh    r3,[r0,0Ch]
AAA_Jump1:
ldr     r0,=20F87F0h              ; na jp, apontar para 20F87F0h
ldr     r2,[r0,4h]
ldrh    r3,[r2,0Ch]
ldr     r2,=400000Ch
strh    r3,[r2]
str     r1,[r0]
ldr     r2,=20F8770h              ; na jp, apontar para 20F8770h
lsl     r1,r1,6h
add     r1,r2,r1
str     r1,[r0,4h]
AAA_Jump2:
add     sp,4h
pop     r4
bx      r14

.pool

;; Alterações feitas para não travar a rom por causa dos textos maiores

.org 0x02007edc
.dw 0x023e0000

.org 0x02000b60
.dw 0x0208dcb4
