onerror {quit -code 1}
source "C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Z0/03-Logica-Combinacional/vunit_out/test_output/a8a6edfaeffa9d5204e37fd61e7c8fe0325f81fa/modelsim/common.do"
set failed [vunit_load]
if {$failed} {quit -code 1}
set failed [vunit_run]
if {$failed} {quit -code 1}
quit -code 0
