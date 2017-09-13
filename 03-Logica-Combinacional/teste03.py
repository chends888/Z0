#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Curso de Elementos de Sistemas
# Desenvolvido por: Rafael Corsi <rafael.corsi@insper.edu.br>
#
# Adaptado de :     Pedro Cunial   <pedrocc4@al.insper.edu.br>
#                   Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 07/2017

from os.path import join, dirname
import sys
import os
import shutil

# para printf coloridos
from termcolor import colored

# vnuit para vhdl
from vunit import VUnitCLI, VUnit

def add_src_lib(lib):
    lib.add_source_files(join("../03-Logica-Combinacional", "src"  ,"A*.vhd")) # source
    lib.add_source_files(join("../03-Logica-Combinacional", "src"  ,"B*.vhd")) # source
    #slib.add_source_files(join("../03-Logica-Combinacional", "src"  ,"D*.vhd")) # source
    lib.add_source_files(join("../03-Logica-Combinacional", "src"  ,"M*.vhd")) # source
    lib.add_source_files(join("../03-Logica-Combinacional", "src"  ,"N*.vhd")) # source
    lib.add_source_files(join("../03-Logica-Combinacional", "src"  ,"O*.vhd")) # source

def add_tb_lib(lib):
    lib.add_source_files(join("../03-Logica-Combinacional/testBench","*.vhd")) # test

def teste03(args):
    cli = VUnitCLI()
    args = cli.parse_args()
    args.gtkwave_fmt='vcd'
    args.num_threads=4

    print(colored("-----------------------------------------", 'magenta'))
    print(colored("--         Testes para VHDL            --", 'magenta'))
    print(colored("-----------------------------------------", 'magenta'))

    ui  = VUnit.from_args(args)
    lib = ui.add_library("lib")

    print(colored("---------- Portas Logicas            ", 'magenta'))
    print(colored("---------- 03-Logica-Combinacional   ", 'magenta'))
    add_src_lib(lib)
    add_tb_lib(lib)

    print(colored("---------- Testando                  ", 'magenta'))
    print(colored("---------- 03-Logica-Combinacional   ", 'magenta'))
    ui._main()

    # copy waveform to test folders
    f = open('./vunit_out/test_output/test_name_to_path_mapping.txt', 'r')
    for line in f:
        hash, name = line.split()
        name = name[4:-4]
        wavesrc = './vunit_out/test_output/' + hash + '/ghdl/wave.vcd'
        wavedst = 'testBench/wave/' + name + '.vcd'
        try:
            shutil.copy(wavesrc, wavedst)
        except:
            pass

    #shutil.rmtree('./vunit_out/')

    #os.system('gtkwave')

if __name__ == "__main__":
    root = os.getcwd()
    print(root)
    teste03(root)






