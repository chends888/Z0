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

def test09():

    print(colored("---------- Testando                  ", 'magenta'))
    print(colored("---------- 09-VM-Translator          ", 'magenta'))

    print(colored("---------- Compilando mvn", 'magenta'))
    os.system("mvn package -DskipTests")

    print(colored("---------- Gerando .nasm dos .vm", 'magenta'))
    os.system("python ./tests/vmtranslator.py -j ./target/VMTranslator-1.0.jar -t ./tests/testesVMTranslator.txt -in ./tests/vm/ -out ./tests/nasm/ -p 3")

    print(colored("---------- Gerando o .hack do .nasm", 'magenta'))
    os.system("python ../Uteis/assembler.py -j ../Uteis/AssemblerZ0-1.0.jar -t ./tests/testesVMTranslator.txt -in ./tests/nasm -o ./tests/hack -p 3")

    print(colored("---------- Emulando                  ", 'magenta'))
    os.system("python ../Uteis/emulate.py -jar ../Uteis/Elemulator/Elemulator.jar -t ./tests/testesVMTranslator.txt -inRAM ./tests/ramIn/ -inHACK ./tests/hack/ -outRAM ./tests/ramOut/  -p 3 -r 512,256")

    print(colored("---------- Verificando                  ", 'magenta'))
    os.system("python -m pytest -v ./tests/testeVMTranslator.py -rs")

if __name__ == "__main__":
    root = os.getcwd()
    test09()
    print(root)

