/**
 * Curso: Elementos de Sistemas
 * Arquivo: AssemblerZ0.java
 * Created by Luciano Soares <lpsoares@insper.edu.br> 
 * Date: 04/02/2017
 */

package assembler;

import java.io.*;
import java.util.*;

/**
 * Classe principal que orquestra execução do Assembler.
 * Opções:
 *   <arquivo nasm>          primeiro parametro é o nome do arquivo nasm a ser aberto
 *   -o <arquivo binario>    parametro indica onde será salvo o arquivo gerado .mif
 *   -d                      ativa modo verborragico
 *   -h                      exibe a ajuda
 */
class AssemblerZ0 {

    static boolean debug;              // flag que especifica se mensagens de debug são impressas

    static String inputFile;
    static String outputFile = null;
    static String outputFileHack = null;
    static String outputFileMif = null;

    static private void argsParse (String[] args){
        String help = "file.nasm -o outFile{.hack .mif} -d debug -h help";

        if (args.length < 2) {  // checa se arquivo foi passado
            System.out.println(help);
            System.exit(01);
        }

        for (int i = 0; i < args.length; i++)
            switch (args[i].charAt(0)) {
                case '-':
                    if (args[i].charAt(1) == 'h') {
                        System.out.println(help);
                        break;
                    } else if (args[i].charAt(1) == 'i') {
                        inputFile = args[i + 1]; // input file
                    } else if (args[i].charAt(1) == 'o') {
                        outputFile = args[i + 1]; // arquivo output
                        i++;
                    } else if (args[i].charAt(1) == 'd') {
                        debug = true;
                    } else {
                        throw new IllegalArgumentException("Argumento não reconhecido: " + args[i]);
                    }
                    break;
                default:
                    inputFile = args[i];
                    break;
            }

        if (inputFile == null || outputFile == null) {
            System.out.println("-i / -o");
            System.exit(02);
        }

        outputFileHack = outputFile.concat(".hack");
        outputFileMif = outputFile.concat(".mif");

        System.out.printf("-i = %s, -o = %s , %s", inputFile, outputFileHack, outputFileMif);

    }

    public static void main(String[] args) {

        // Parse arguments from command line call.
        argsParse(args);

        // Starts to read file and generates de outputs
        try {
            // Cria objeto assembler auxiliar
            Assemble assembler = new Assemble(  inputFile,
                                                true,
                                                outputFileHack,
                                                true,
                                                outputFileMif,
                                                false,
                                                16,
                                                debug);

            // Cria tabela de símbolos
            assembler.fillSymbolTable();

            // Cria linguagem de maquina
            assembler.generateMachineCode();

            // Fecha arquivos
            assembler.close();

        } catch (FileNotFoundException ex){
            Error.error("Arquivo \'" + inputFile + "\' nao encontrado");
        } catch (IOException ex) {
            Error.error("uma excessao de i/o foi lancada");
        }

    }
}


