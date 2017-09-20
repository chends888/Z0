onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Z0/06-Unidade-Central-de-Processamento/vunit_out/test_output/a75fe8e1779f6a1f2b60e6ef62d1d0adf3793143/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
