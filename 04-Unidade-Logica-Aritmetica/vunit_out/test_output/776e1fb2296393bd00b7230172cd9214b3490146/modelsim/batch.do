onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Z0/04-Unidade-Logica-Aritmetica/vunit_out/test_output/776e1fb2296393bd00b7230172cd9214b3490146/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
