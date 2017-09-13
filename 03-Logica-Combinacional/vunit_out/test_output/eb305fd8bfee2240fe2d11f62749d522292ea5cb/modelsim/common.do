
proc vunit_help {} {
    puts {List of VUnit commands:}
    puts {vunit_help}
    puts {  - Prints this help}
    puts {vunit_load [vsim_extra_args]}
    puts {  - Load design with correct generics for the test}
    puts {  - Optional first argument are passed as extra flags to vsim}
    puts {vunit_user_init}
    puts {  - Re-runs the user defined init file}
    puts {vunit_run}
    puts {  - Run test, must do vunit_load first}
    puts {vunit_compile}
    puts {  - Recompiles the source files}
    puts {vunit_restart}
    puts {  - Recompiles the source files}
    puts {  - and re-runs the simulation if the compile was successful}
}
proc _vunit_source_init_files_after_load {} {
    return 0
}

proc vunit_load {{vsim_extra_args ""}} {
    set vsim_failed [catch {
        eval vsim ${vsim_extra_args} {-wlf {C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/vunit_out/test_output/eb305fd8bfee2240fe2d11f62749d522292ea5cb/modelsim/vsim.wlf} -quiet -t ps -onfinish stop  -g/tb_mux4way/runner_cfg={"active python runner : true,enabled_test_cases : ,output path : C::/Users/Gustavo Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/vunit_out/test_output/eb305fd8bfee2240fe2d11f62749d522292ea5cb/,tb path : C::/Users/Gustavo Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/testBench/"} lib.tb_mux4way(tb)   -L vunit_lib -L lib}
    }]

    if {${vsim_failed}} {
       echo Command 'vsim ${vsim_extra_args} -wlf {C:/Users/Gustavo\ Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/vunit_out/test_output/eb305fd8bfee2240fe2d11f62749d522292ea5cb/modelsim/vsim.wlf} -quiet -t ps -onfinish stop  -g/tb_mux4way/runner_cfg={"active python runner : true,enabled_test_cases : ,output path : C::/Users/Gustavo Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/vunit_out/test_output/eb305fd8bfee2240fe2d11f62749d522292ea5cb/,tb path : C::/Users/Gustavo Gobetti/Documents/Insper/4-Semestre-2017/Elementos-de-Sistema-2/Z0/03-Logica-Combinacional/testBench/"} lib.tb_mux4way(tb)   -L vunit_lib -L lib' failed
       echo Bad flag from vsim_extra_args?
       return 1
    }

    if {[_vunit_source_init_files_after_load]} {
        return 1
    }

    set no_finished_signal [catch {examine -internal {/vunit_finished}}]
    set no_vhdl_test_runner_exit [catch {examine -internal {/run_base_pkg/runner.exit_simulation}}]
    set no_verilog_test_runner_exit [catch {examine -internal {/vunit_pkg/__runner__}}]

    if {${no_finished_signal} && ${no_vhdl_test_runner_exit} && ${no_verilog_test_runner_exit}}  {
        echo {Error: Found none of either simulation shutdown mechanisms}
        echo {Error: 1) No vunit_finished signal on test bench top level}
        echo {Error: 2) No vunit test runner package used}
        return 1
    }


    global BreakOnAssertion
    set BreakOnAssertion 2

    global NumericStdNoWarnings
    set NumericStdNoWarnings 0

    global StdArithNoWarnings
    set StdArithNoWarnings 0

    
    return 0
}

proc _vunit_run {} {
    proc on_break {} {
        resume
    }
    onbreak {on_break}

    set has_vunit_finished_signal [expr ![catch {examine -internal {/vunit_finished}}]]
    set has_vhdl_runner [expr ![catch {examine -internal {/run_base_pkg/runner.exit_simulation}}]]
    set has_verilog_runner [expr ![catch {examine -internal {/vunit_pkg/__runner__}}]]

    if {${has_vunit_finished_signal}} {
        set exit_boolean {/vunit_finished}
        set status_boolean {/vunit_finished}
        set true_value TRUE
    } elseif {${has_vhdl_runner}} {
        set exit_boolean {/run_base_pkg/runner.exit_simulation}
        set status_boolean {/run_base_pkg/runner.exit_without_errors}
        set true_value TRUE
    } elseif {${has_verilog_runner}} {
        set exit_boolean {/vunit_pkg/__runner__.exit_simulation}
        set status_boolean {/vunit_pkg/__runner__.exit_without_errors}
        set true_value 1
    } else {
        echo "No finish mechanism detected"
        return 1;
    }

    when -fast "${exit_boolean} = ${true_value}" {
        echo "Finished"
        stop
        resume
    }

    run -all
    set failed [expr [examine -radix unsigned -internal ${status_boolean}]!=${true_value}]
    if {$failed} {
        catch {
            # tb command can fail when error comes from pli
            echo
            echo "Stack trace result from 'tb' command"
            echo [tb]
            echo
            echo "Surrounding code from 'see' command"
            echo [see]
        }
    }
    return $failed
}

proc vunit_run {} {
    if {[catch {_vunit_run} failed_or_err]} {
        echo $failed_or_err
        return 1;
    }
    return $failed_or_err;
}

proc _vunit_sim_restart {} {
    restart -f
}

proc vunit_compile {} {
    set cmd_show {C:\Users\Gustavo Gobetti\Anaconda\python.exe -u teste03.py --compile}
    puts "Re-compiling using command ${cmd_show}"

    set chan [open |[list {C:\Users\Gustavo Gobetti\Anaconda\python.exe} {-u} {-c} {import sys;import subprocess;exit(subprocess.call(['C:\\Users\\Gustavo Gobetti\\Anaconda\\python.exe', '-u', 'teste03.py', '--compile'], cwd='C:\\Users\\Gustavo Gobetti\\Documents\\Insper\\4-Semestre-2017\\Elementos-de-Sistema-2\\Z0\\03-Logica-Combinacional', bufsize=0, universal_newlines=True, stdout=sys.stdout, stderr=sys.stdout))}] r]

    while {[gets $chan line] >= 0} {
        puts $line
    }

    if {[catch {close $chan} error_msg]} {
        puts "Re-compile failed"
        puts ${error_msg}
        return 1
    } else {
        puts "Re-compile finished"
        return 0
    }
}

proc vunit_restart {} {
    if {![vunit_compile]} {
        _vunit_sim_restart
        vunit_run
    }
}
