; bed.g
; called to perform automatic bed compensation via G32

; Heat bed and nozzle
; And allow bed to reach temperature before continuing
M104 T2 S150
M190 S60 ; Change depending on print bed temperature

; Clear any bed transform
G29 S2 ; Does the same as M561!

; Evidence it's loading bed.g, move the bed down and up
G91
G1 Z20 F3600 S1
G1 Z-20 F3600
G90

; Mesh Bed Leveling -> Mesh defined in config.g
G29 S0 ; Run the bed leveling

; G30 bed compensation - Alternative to Mesh Bed Leveling
; For more information, visit https://reprap.org/wiki/G-code#G30:_Single_Z-Probe
; Supported up to 5 points

; X - Pattern
;G30	P0	X	41	Y	30	Z	-99999	H	-0.21
;G30	P1	X	41	Y	378	Z	-99999	H	-0.4	
;G30	P2	X	371	Y	378	Z	-99999	H	-0.5	
;G30	P3	X	371	Y	30	Z	-99999	H	-0.75
;G30	P4	X	191	Y	198	Z	-99999	H	0	S5

; + Pattern
;G30		P0	X	129	Y	130	Z	-99999	H	0
;G30		P1	X	126	Y	267	Z	-99999	H	0
;G30		P2	X	271	Y	270	Z	-99999	H	0
;G30		P3	X	273	Y	132	Z	-99999	H	0
;G30		P4	X	200	Y	200	Z	-99999	H	0	S5