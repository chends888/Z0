#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Curso de Elementos de Sistemas
# Desenvolvido por: Luciano Soares <lpsoares@insper.edu.br>
# Data de criação: 30/03/2017

import subprocess
import loadTestes
import time
import os
import argparse
import platform

#PATH_ELEMULATOR = '../Uteis/Elemulator/Elemulator.jar'

#http://stackoverflow.com/questions/377017/test-if-executable-exists-in-python
def cmd_exists(cmd):
    return subprocess.call("type " + cmd, shell=True,
        stdout=subprocess.PIPE, stderr=subprocess.PIPE) == 0

def emulate(jar,testes,in_dir_ram,in_dir_hack,out_dir_ram,bits,processos,resolution, verbose):

    debug = False

    processes = set()
    max_processes = processos
    start_time = time.time()

    PATH_ELEMULATOR = jar

    if platform.system()=="Windows":
        shell = True
    else:
        shell = False

    nomes_testes = loadTestes.testes(testes)

    n_error = 0
    n_done = 0
    n_skiped = 0

    count = 0

    for j in nomes_testes:
        nome = j.split()
        if int(nome[1]) > 0:
            for i in range(int(nome[1])):
                #print('....', end='', flush=True)
                print(nome)
                # Testa se arquivos existem, senão pula
                if os.path.exists(in_dir_hack+"{0}.hack".format(nome[0])):
                    rotina = ['java', '-jar', PATH_ELEMULATOR,
                        os.path.abspath(in_dir_hack+"{0}.hack".format(nome[0])),
                        "-i",
                        os.path.abspath(in_dir_ram+"{0}{1}_in.mif".format(nome[0],i)),
                        "-o",
                        os.path.abspath(out_dir_ram+"{0}{1}_out.mif".format(nome[0],i)),
                        "-c",
                        nome[2]]
                    if(debug):
                        print(rotina)
                    if bits==32:
                        rotina.append("-b")
                        rotina.append("32")
                    if(verbose):
                        print("\nEmulating: "+nome[0]+" >> Exec: "+" ".join(rotina))
                    processes.add(subprocess.Popen(rotina))
                    count += 1
                    while count >= max_processes:
                        count = 0
                        time.sleep(0.1)
                        for p in processes:
                            if p.poll() is None:
                                count += 1
                else:
                    n_skiped += 1

        elif int(nome[1]) == 0:     # caso só um teste

            # Testa se arquivos existem, senão pula
            if os.path.exists(in_dir_hack+"{0}.hack".format(nome[0])):

                rotina = ['java', '-jar', PATH_ELEMULATOR,
                    in_dir_hack+"{0}.hack".format(nome[0]),
                    "-i",in_dir_ram+"{0}_in.mif".format(nome[0]),
                    "-o",out_dir_ram+"{0}_out.mif".format(nome[0]),"-c",nome[2]]
                if bits==32:
                    rotina.append("-b")
                    rotina.append("32")

                if(verbose):
                    print("\nEmulating: "+nome[0]+" >> Exec: "+" ".join(rotina))
                processes.add(subprocess.Popen(rotina))
                count += 1
                while count >= max_processes:
                    count = 0
                    time.sleep(0.1)
                    for p in processes:
                        if p.poll() is None:
                            count += 1
            else:
                n_skiped += 1

        else:   # caso saida gráfica

            # Testa se arquivos existem, senão pula
            if os.path.exists(in_dir_hack+"{0}.hack".format(nome[0])):

                rotina = ['java', '-jar', PATH_ELEMULATOR,
                    in_dir_hack+"{0}.hack".format(nome[0]),
                    "-p",out_dir_ram+"{0}.pbm".format(nome[0]),
                    "-o",out_dir_ram+"{0}_out.mif".format(nome[0]),
                    "-c",nome[2],"-r",resolution[0],resolution[1]]

                if in_dir_ram:
                    rotina.append("-i")
                    rotina.append(in_dir_ram+"{0}_in.mif".format(nome[0]))
                if bits==32:
                    rotina.append("-b")
                    rotina.append("32")

                if(verbose):
                    print("\nEmulating: "+nome[0]+" >> Exec: "+" ".join(rotina))
                processes.add(subprocess.Popen(rotina))
                count += 1
                while count >= max_processes:
                    count = 0
                    time.sleep(0.1)
                    for p in processes:
                        if p.poll() is None:
                            count += 1
            else:
                n_skiped += 1

    #Check if all the child processes were closed
    for p in processes:
        p.wait()
        if(p.returncode==0):
            n_done+=1
        else:
            n_error+=1

    # exibe as imagens no terminal
    if cmd_exists('img2txt2'):
        for i in nomes_testes:
            nome = i.split()
            if int(nome[1]) < 0:
                subprocess.call(['echo'], shell=shell)
                subprocess.call(['echo',"{0}.pbm".format(nome[0],i)], shell=shell)
                subprocess.call(['img2txt',out_dir+"{0}.pbm".format(nome[0],i)], shell=shell)

    elapsed_time = time.time() - start_time
    if(verbose):
        print('\033[92m'+"Emulated {0} process(es) in {1:.2f} seconds".format(n_done,elapsed_time)+'\033[0m')

    if(n_skiped!=0):
        if(verbose):
            print('\033[93m'+"Skipped {0} file(s)".format(n_skiped)+'\033[0m')

    if(n_error!=0):
        if(verbose):
            print('\033[91m'+"Failed {0} process(es)".format(n_error)+'\033[0m')
        exit(n_error)

if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument("-t", "--tests", required=True,help="arquivo com lista de testes")
    ap.add_argument("-jar", "--emulator", required=True,help="[jar] Emulador java")
    ap.add_argument("-inRAM", "--in_dir_ram", required=False,help="[MIF] RAM estado inicial (pre simulacao)")
    ap.add_argument("-inHACK", "--in_dir_hack", required=False,help="[HACK] Assembler para simulação")
    ap.add_argument("-outRAM", "--out_dir_ram", required=True,help="[MIF] RAM estado final (pós simulacao)")
    ap.add_argument("-p", "--processos", required=True,help="numero de threads a se paralelizar")
    ap.add_argument("-r", "--resolution", required=False,help="resolução em X e Y")
    ap.add_argument("-b", "--bits", required=False,help="bits da arquitetura")
    ap.add_argument("-V", "--verbose", required=False,help="verbose (log)")
    args = vars(ap.parse_args())
    proc = int(args["processos"])

    if args["bits"]:
        bita = int(args["bits"])
    else:
        bita=16

    if args["resolution"] != None:
        res = args["resolution"].split(",")
    else:
        res = ['320', '240']    # valor padrão

    emulate(jar=args["emulator"], testes=args["tests"],in_dir_ram=args["in_dir_ram"],in_dir_hack=args["in_dir_hack"],out_dir_ram=args["out_dir_ram"],bits=bita,processos=proc,resolution=res, verbose=args["verbose"])
