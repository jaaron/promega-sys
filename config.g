; CONFIGURATION FILE for Duet Maestro 
; K'Tana Nozzle
; Last modified October 1, 2018

; Executed by the firmware on start-up

; Headers within parenthesis are headings in Duet3D documentation=https://duet3d.com/wiki/Configuring_RepRapFirmware_for_a_Cartesian_printer
; Visit https://reprap.org/wiki/G-code for an explanation of G-code commands

; --- SECTION: GENERAL PREFERENCES ( ) ---

M564 S1 H1									; Enables Homing Requirement For Motor Activation and set axes limits

; --- SECTION: Z-PROBE & MESH COMPENSATION ---

M98 P"machine_zprobe.g"						; configure the z probe

M98 P"machine_bedmesh.g"					; configure the bed mesh

G29 S1										; Load heightmap after power cycle

; --- SECTION: DRIVES (MOVEMENT SECTION) & ENDSTOPS ---

; M667 S1										; Enable coreXY mode
M669 K1
M569 P0 S0 D3 V0							; Drive 0 goes forwards, CoreXY_1, stealth chop, disable spread cycle
M569 P1 S1 D3 V0							; Drive 1 goes forwards, CoreXY_2, stealth chop, disable spread cycle
M569 P2 S1 D3 V0							; Drive 2 goes forwards, Z Motor, stealth chop, disable spread cycle
M569 P3 S0 D3 V800							; Drive 3 goes forwards, Left Extruder, stealth chop, spread cycle only on retractions (basically)
M569 P4 S1 D3 V800							; Drive 4 goes forwards, Right Extruder, stealth chop, spread cycle only on retractions (basically)
M584 X0 Y1 Z2 E3:4                                         ; set drive mapping

M98 P"machine_endstoptypes.g"					; set endstop types
M98 P"machine_steppercurrent.g"				; set stepper currents
M98 P"machine_stepperspeed.g"					; set stepper speeds
M98 P"machine_axisdimension.g"				; configure the axes dimensions
M98 P"machine_axissteps.g"					; configure the axes steps per mm
M98 P"machine_extruderstep.g"					; configure the extruder steps
G21											; Work in millimetres
G90											; Set to absolute coordinates...
M84 S1										; Set idle timeout

; --- SECTION: HEATERS, BED & THERMISTOR ---
; H0 is bed
; H1 is left heater
; H2 is right heater
M308 S0 P"bedtemp" Y"thermistor" T100000 B4138 R2200       ; configure sensor 0 as thermistor on pin bedtemp
M950 H0 C"bedheat" T0                                      ; create bed heater output on bedheat and map it to sensor 0
M140 H0

M308 S1 P"e0temp" Y"pt1000" T100000 B4138 R2200        ; configure sensor 1 as thermistor on pin e0temp
M950 H1 C"e0heat" T1                                       ; create nozzle heater output on e0heat and map it to sensor 1

M308 S2 P"e1temp" Y"pt1000" T100000 B4138 R2200        ; configure sensor 2 as thermistor on pin e1temp
M950 H2 C"e1heat" T2                                       ; create nozzle heater output on e1heat and map it to sensor 2

M570 H0 P25 T30								; Allow heater to be off by as much as 30C for 25 seconds
M570 H1 P15 T30								; Allow heater to be off by as much as 30C for 15 seconds
M570 H2 P15 T30								; Allow heater to be off by as much as 30C for 15 seconds

; M305 P0 T100000 B4138 C0 R2200				; Set thermistor + ADC parameters for heater 0, For heated Bed thermistor
; M305 P1 X501 R2200							; Define left side extruder PT1000 
; M305 P2 X502 R2200							; Define right side extruder PT1000 
M307 H0 A78.9 C265.2 D9.5 S1.00 V24.0 B0	; Forcing heated bed PID control after power-cycle. Basic bed heating auto-tune
M307 H1 A309 C96 D5.2 S0.75 V24.1 B0		; Set PID values use M303 auto-tune calibration settings
M307 H2 A309 C96 D5.2 S0.75 V24.1 B0		; Set PID values use M303 auto-tune calibration settings
M302 P1										; Allow Cold extrudes
M98 P"machine_maxtemp.g"						; set bed and extruder max temperatures

; --- SECTION: FANS ( ) ---
M950 F0 C"fan0" Q500                                       ; create fan 0 on pin fan0 and set its frequency
M106 P0 S1 H-1                                             ; set fan 0 value. Thermostatic control is turned off
M950 F1 C"fan1" Q500                                       ; create fan 1 on pin fan1 and set its frequency
M106 P1 S1 H-1                                             ; set fan 1 value. Thermostatic control is turned off
M950 F2 C"fan2" Q500                                       ; create fan 2 on pin fan2 and set its frequency
M106 P2 S1 H-1                                             ; set fan 2 value. Thermostatic control is turned off

; M106 P0 S0 I0 F4 H-1 L0.3					; Filter fan. Set fan 0 value, PWM signal inversion and frequency. Thermostatic control is turned off, Minimum fan value 0.3, Speed 100%
; M106 P1 S0 I0 F4 H-1 L0.3					; Cold-Section fan. Set fan 1 value, PWM signal inversion and frequency. Thermostatic control is turned off, Minimum fan value 0.3, Speed 100%
; M106 P2 S0 I0 F4 H-1 L0.3					; Nozzle fan. Set fan 2 value, PWM signal inversion and frequency. Thermostatic control is turned off, Minimum fan value 0.3, Speed 100%

; --- SECTION: TOOLS ( ) --- 

; Comment: Remember! H0 is the heated bed!
; Comment: D0 is the first driver after movement (X, Y and Z) drives, which is left extruder
; D1 is right extruder

M98 P"machine_ktana_tools.g"					; Define ktana tools

T0											; Automatic tool select

; --- SECTION: NETWORKS (PROLOGUE & COMMUNCATIONS SECTION) ---
M98 P"machine_access.g"						; set machine name and IP
M586 P0 S1									; Enable HTTP
M586 P1 S0									; Disable FTP
M586 P2 S0									; Disable Telnet

; --- SECTION: MISCELLANEOUS --- 

M572 D0:1 S0.07								; Extruder Pressure Advance
;M98 Pqc.g									; Do NOT uncomment unless you really know what you're doing