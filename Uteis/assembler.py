
#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 30/03/2017

import subprocess
import time
import argparse
import os.path
import platform
import os

def loadtestes(nome_arquivo):

        nomes_testes = []

        # rotina de leitura do resultado da emulação
        with open(nome_arquivo, 'r') as arquivo:
                tmp = arquivo.read().splitlines()

                for i in tmp:
                        if i.strip():
                                if i.strip()[0]!='#':
                                        nomes_testes.append(i)
        return nomes_testes

def assembler(jar,testes,in_dir,out_dir,bits,processos):

        start_time   = time.time()
        rotina_mkdir = ["mkdir"]
        shell=False
        debug=False

        if platform.system()=="Windows":
                jar = jar.replace('/','\\')
                testes = testes.replace('/','\\')
                in_dir = in_dir.replace('/','\\')
                out_dir = out_dir.replace('/','\\')
                shell=True
        else:
                rotina_mkdir.append("-p") # para criar os subdiretórios no mkdir no UNIX

        #rotina_mkdir.append(out_dir)
        #subprocess.call(rotina_mkdir, shell=shell) # cria subdiretório para resultados

        nomes_testes = loadtestes(testes)

        error_code = 0
        n_done = 0
        n_error = 0
        n_skiped = 0

        in_dir = os.path.abspath(in_dir) + "//"
        out_dir = os.path.abspath(out_dir) +"//"

        for i in nomes_testes:

                nome = i.split()

                if(debug):
                        print(in_dir+"{0}.nasm".format(nome[0]))
                        print(nome)

                # Testa se arquivos existem, senão pula
                if os.path.exists(in_dir+"{0}.nasm".format(nome[0])):
                        rotina = ['java', '-jar', jar,
                                  in_dir+"{0}.nasm".format(nome[0]),
                                  "-o",out_dir+"{0}".format(nome[0])]
                        if(debug):
                                print(rotina)
                        if bits==32:
                                rotina.append("-b")
                                rotina.append("32")
                        error = subprocess.call(rotina)
                        if(error!=0):
                                error_code += error
                                n_error += 1
                        else:
                                n_done += 1
                else:
                        n_skiped += 1

        elapsed_time = time.time() - start_time
        print('\033[92m'+"Assembled {0} file(s) in {1:.2f} seconds".format(n_done,elapsed_time)+'\033[0m')

        if(n_skiped!=0):
                print('\033[93m'+"Skipped {0} file(s)".format(n_skiped)+'\033[0m')

        if(error_code!=0):
                print('\033[91m'+"Failed {0} file(s)".format(n_error)+'\033[0m')
                exit(error_code)

if __name__ == "__main__":
        ap = argparse.ArgumentParser()
        ap.add_argument("-j", "--jar",       required=True,help="arquivo jar para executar")
        ap.add_argument("-t", "--tests",     required=True,help="arquivo com lista de testes")
        ap.add_argument("-in","--in_dir",    required=True,help="caminho para codigos")
        ap.add_argument("-o", "--out_dir",   required=True,help="[HACK] e [MIF] ")
        ap.add_argument("-p", "--processos", required=True,help="numero de threads a se paralelizar")
        ap.add_argument("-b", "--bits",      required=False,help="bits da arquitetura")
        args = vars(ap.parse_args())

        if args["bits"]:
                bita = int(args["bits"])
        else:
                bita=16

        assembler(jar=args["jar"],testes=args["tests"],in_dir=args["in_dir"],out_dir=args["out_dir"],bits=bita,processos=int(args["processos"]))
