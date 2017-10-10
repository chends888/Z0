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

def test07(args):

    print(colored("---------- Testando                  ", 'magenta'))
    print(colored("---------- 07-Assembly               ", 'magenta'))

    os.system("python ../Uteis/assembler.py -j ../Uteis/AssemblerZ0.jar -t ./testBench/testesAssembly.txt -in ../07-Assembly/src/ -outMIF ./bin/mif_altera/ -outHACK ./bin/hack/ -p 3")

<<<<<<< HEAD
    #print(colored("---------- Emulando                  ", 'magenta'))
    #os.system("python ../Uteis/emulate.py -jar ../Uteis/Elemulator/Elemulator.jar -t ./testBench/testesAssembly.txt -inRAM ./testBench/testesAssembly/ -inHACK ./bin/hack/ -outRAM ./bin/mif_ram/ -p 3 -r 512,256")

    #print(colored("---------- Verificando                  ", 'magenta'))
    #os.system("python -m pytest -v ../Uteis/testeAssembly.py -rxs")
=======
<<<<<<< HEAD
    #print(colored("---------- Emulando                  ", 'magenta'))
    #os.system("python ../Uteis/emulate.py -jar ../Uteis/Elemulator/Elemulator.jar -t ./testBench/testesAssembly.txt -inRAM ./testBench/testesAssembly/ -inHACK ./bin/hack/ -outRAM ./bin/mif_ram/ -p 3 -r 512,256")

    #print(colored("---------- Verificando                  ", 'magenta'))
    #os.system("python -m pytest -v ../Uteis/testeAssembly.py -rxs")
=======
    print(colored("---------- Emulando                  ", 'magenta'))
    os.system("python ../Uteis/emulate.py -jar ../Uteis/Elemulator/Elemulator.jar -t ./testBench/testesAssembly.txt -inRAM ./testBench/testesAssembly/ -inHACK ./bin/hack/ -outRAM ./bin/mif_ram/ -p 3 -r 512,256")

    print(colored("---------- Verificando                  ", 'magenta'))
    os.system("python -m pytest -v ../Uteis/testeAssembly.py -rxs")
>>>>>>> 5e41e46b24dd4e1f20efbd51f421498432cb2b86
>>>>>>> 3f67611405ac62bf565e72452d1e7f508aaf7f24

if __name__ == "__main__":
    root = os.getcwd()
    print(root)
    test07(root)
