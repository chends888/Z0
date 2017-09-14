onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/04-Unidade-Logica-Aritmetica/vunit_out/test_output/a8ad0313227e6e4cf7e1113b280dcedad766e677/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
