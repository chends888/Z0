onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/05-Logica-Sequencial/vunit_out/test_output/c5c66660a959522836aa1c4c7aae83ec20d9bfef/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
