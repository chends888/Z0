onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Z0/04-Unidade-Logica-Aritmetica/vunit_out/test_output/2eeb55b34fbd7b5d1c8fa04094fa8e04485ace6a/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
