onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/vunit_out/test_output/fd54692e9cc3108fd2877e54a5465bee032e18cb/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
