onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/vunit_out/test_output/8ba639f56fefebe7cb91cce60b081c070576fecc/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
