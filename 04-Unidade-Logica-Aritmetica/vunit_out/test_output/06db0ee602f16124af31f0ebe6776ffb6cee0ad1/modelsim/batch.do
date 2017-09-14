onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/04-Unidade-Logica-Aritmetica/vunit_out/test_output/06db0ee602f16124af31f0ebe6776ffb6cee0ad1/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
