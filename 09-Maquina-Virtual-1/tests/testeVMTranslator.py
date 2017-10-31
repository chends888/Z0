#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Testador da tradução de máquina virtual a pilha
# Arquivo: testVMTranslator.py
# Criado por: Luciano Soares <lpsoares@insper.edu.br>
# Data: 4/05/2017

import sys, getopt
import unittest
import pytest
import loadTestes
import checkUnitTests
import os

nomes_testes = loadTestes.testes(os.path.abspath("./tests/testesVMTranslator.txt"))

# Testes a serem realizados
@pytest.mark.parametrize(('nomes_testes'),nomes_testes)
def test_Assembly(nomes_testes):

        nomes_testes = nomes_testes.split()

        for i in range (int(nomes_testes[1])):
            resultado = os.path.abspath("tests/ramOut/{0}{1}_out.mif".format(nomes_testes[0],i ))
            teste = os.path.abspath("tests/ramIn/{0}{1}_tst.mif".format(nomes_testes[0], i))
            debug = False
            ram = {}
            validacao = {}

            # rotina de leitura do resultado da emulação
            with open(resultado, 'r') as arquivo:
                    linhas = arquivo.read().splitlines()

                    for linha in linhas:
                            alocacao = linha.split(":")
                            ram[int(alocacao[0].strip())] = int("0b"+alocacao[1].strip(),2)

                    if debug:
                            print("RAM") 
                            for e,v in ram.items():
                                    print("|{0}|  =>  |{1:016b}|".format(e,v))
                            print("\n")

            # rotina do teste da emulação
            with open(teste, 'r') as arquivo:
                    linhas = arquivo.read().splitlines()
                    for linha in linhas:
                            alocacao = linha.split(":")
                            print(int(alocacao[0].strip()))
                            validacao[int(alocacao[0].strip())] = int("0b"+alocacao[1].strip(),2)
                    if debug:
                            print("Teste")
                            for e,v in validacao.items():
                                    print("|{0}|  =>  |{1:016b}|".format(e,v))
                            print("\n")

            for e,v in validacao.items():
                    assert (v==ram[e]),"Erro: {0} RAM[{1}]={2:016b}, valor esperado ({3:016b})".format(nomes_testes[0],e,ram[e],v)
