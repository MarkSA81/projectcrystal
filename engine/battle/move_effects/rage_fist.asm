; Rage Fist effect - increases power by 50 for each hit received
; Base power: 50, Max: 350 (6 hits)
; Counter persists when switched

BattleCommand_ragefist:
	; Get current rage fist counter from wRageFistCounter
	ld a, [wRageFistCounter]
	
	; Cap at 6 hits (max power 350)
	cp 6
	jr c, .counter_ok
	ld a, 6
.counter_ok:
	; Calculate power: 50 + (counter * 50)
	ld b, a
	ld a, 50
	ld c, 0
.add_loop:
	ld a, c
	add 50
	ld c, a
	dec b
	jr nz, .add_loop
	
	; Store power in wCurDamage
	ld a, c
	ld [wCurDamage], a
	ld a, 0
	ld [wCurDamage + 1], a
	
	; Increment counter (will be capped at 6)
	ld a, [wRageFistCounter]
	inc a
	cp 7
	jr c, .store_counter
	ld a, 6
.store_counter:
	ld [wRageFistCounter], a
	
	ret
