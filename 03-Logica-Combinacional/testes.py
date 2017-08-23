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


def vhdl(args):
    cli = VUnitCLI()
    args = cli.parse_args()
    args.gtkwave_fmt='vcd'
    args.num_threads=4

    print(colored("-----------------------------------------", 'magenta'))
    print(colored("--         Testes para VHDL            --", 'magenta'))
    print(colored("-----------------------------------------", 'magenta'))

    print(colored("---------- Portas Logicas            ", 'magenta'))
    ui  = VUnit.from_args(args)
    lib = ui.add_library("lib")
    lib.add_source_files(join("src"  ,"A*.vhd")) # source
    lib.add_source_files(join("src"  ,"B*.vhd")) # source
    lib.add_source_files(join("src"  ,"D*.vhd")) # source
    lib.add_source_files(join("src"  ,"M*.vhd")) # source
    lib.add_source_files(join("src"  ,"N*.vhd")) # source
    lib.add_source_files(join("src"  ,"O*.vhd")) # source
    lib.add_source_files(join("testes","*.vhd")) # test
    ui._main()

    # copy waveform to test folders
    f = open('./vunit_out/test_output/test_name_to_path_mapping.txt', 'r')
    for line in f:
        hash, name = line.split()
        name = name[4:-4]
        wavesrc = './vunit_out/test_output/' + hash + '/ghdl/wave.vcd'
        wavedst = 'testes/resultados/' + name + '.vcd'
        shutil.copy(wavesrc, wavedst)
    shutil.rmtree('./vunit_out/')

    #os.system('gtkwave')

if __name__ == "__main__":
    root = os.getcwd()
    print(root)
    vhdl(root)






