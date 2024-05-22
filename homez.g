; homez.g
; called to home the Z axis
;

; ============= PRE-HOMING =====================

; Ignore Machine boundaries
M564 H0 S0

; Turn off bed leveling during homing
G29 S2 ; Does the same as M561!
G29 S2 ; Do it twice because once just isn't enough

; Switch to Origin Tool
T0

; Relative positioning
G91

; Provide Z height clearance
G1 Z10 F750 H1


; ============ HOME Z ==============

; Rapid Z until limit switch triggers
G0 Z450 F1500 H1

; Back off to release limit switch
G0 Z-15 F1500

; Slow advance to trigger limit switch
G0 Z20 F120 H1

M98 P"machine_zendstop.g" ; Set Z Endstop height
M98 P"machine_zprobe.g"   ; Set Z Probe distance

; ============ Post-Homing ==============

; Revert to absolute coordinates
G90

; Re-enable mesh leveling
G29 S1

M98 P"machine_axisdimension.g" ; Set Axes Limits

; Stop movement across limits, enable boundaries, homing requirement
M564 H1 S1
