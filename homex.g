; homex.g
; called to home the X axis
;

; same as homey.g because coreXY
; Front left corner is (0,0)

; ============= PRE-HOMING SEQUENCE =====================

; Ignore Machine boundaries
M564 H0 S0

; Turn off bed leveling during homing
M561
G29 S2

; Switch to Origin Tool
T0

; Relative positioning
G91

; Provide Z height clearance
G1 Z10 F1200 S1


; ================== HOME Y ============================

; Move away from x limit to prevent damage to endstop
G0 X-20 F3000 S1

; Rapid Y until limit switch triggers
G0 Y450 F3000 S1

; Back off to release limit switch
G0 Y-6 F3000

; Slow advance to trigger limit switch
G0 Y10 F120 S1

; Set this location as Y = 385mm
G92 Y385

; Move the gantry slightly away from back of printer, to allow travel past the bolt mounting the gantry bracket
G0 Y-5 F1200



; ============= HOME X ====================

; Rapid X until limit switch triggers
G0 X450 F3000 S1

; Back off to release limit switch
G0 X-6 F3000

; Slow advance to trigger limit switch
G0 X10 F120 S1

; Set this location as X = 380mm
G92 X380

; Move away from the limit switch, to prevent damage to it upon next move
G0 X-5 F3000

; ============ Post-Homing ==============

; Revert to absolute coordinates
G91

; Re-enable mesh leveling
G29 S1

; Set Axes Limits
M208 X0 Y0 Z-3 S1 ; Set axis minima
M208 X374 Y380 Z377 S0 ; Set axis maxima

; Stop movement across limits, enable boundaries
M564 H0 S1
