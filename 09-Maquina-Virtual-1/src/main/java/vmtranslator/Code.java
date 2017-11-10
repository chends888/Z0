/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package vmtranslator;

import java.util.*;
import java.io.*;
import java.nio.file.*;

/** 
 * Traduz da linguagem vm para códigos assembly.
 */
public class Code {

    PrintWriter outputFile = null;
    String filename = null;

    /** 
     * Abre o arquivo de entrada VM e se prepara para analisá-lo.
     * @param filename nome do arquivo NASM que receberá o código traduzido.
     */
    public Code(String filename) throws  FileNotFoundException, IOException{
        File file = new File(filename);
        this.outputFile = new PrintWriter(new FileWriter(file));
    }



    public List<String> reduceSP () {
        List<String> commands = new ArrayList<String>();
        commands.add("leaw $SP,%A");
        commands.add("movw (%A),%D");
        commands.add("decw %D");
        commands.add("movw %D,(%A)");
        return commands;
    }

    public List<String> increaseSP () {
        List<String> commands = new ArrayList<String>();
        commands.add("leaw $SP,%A");
        commands.add("movw (%A),%D");
        commands.add("incw %D");
        commands.add("movw %D,(%A)");
        return commands;
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando aritmético.
     * @param  command comando aritmético a ser analisado.
     */
    public void writeArithmetic(String command) {
        if ( command.equals("")) {
            Error.error("Instrução invalida");
        }

        List<String> commands = new ArrayList<String>();

        if(command.equals("add")) {
            // Comentário para facilitar o debug:
            commands.add("; ADD");

            commands.addAll(reduceSP());

            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");

            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");

            commands.add("addw (%A),%D,%D");

            commands.add("movw %D,(%A)");
            
        }

        else if (command.equals("sub")) {
            commands.add("; SUB");

            commands.addAll(reduceSP());

            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");

            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");

            commands.add("subw (%A),%D,%D");

            commands.add("movw %D,(%A)");
        }

        else if (command.equals("neg")) {
            commands.add("; NEG");

            commands.addAll(reduceSP());

            commands.add("movw (%A),%D");

            commands.add("negw %D");

            commands.add("movw %D,(%A)");

            commands.addAll(increaseSP());

        }

        else if (command.equals("eq")) {
        }

        else if (command.equals("gt")) {
        }

        else if (command.equals("lt")) {
        }

        else if (command.equals("and")) {
            commands.add("; AND");

            commands.addAll(reduceSP());

            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");

            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");

            commands.add("andw (%A),%D,%D");

            commands.add("movw %D,(%A)");
        }

        else if (command.equals("or")) {
            commands.add("; OR");

            commands.addAll(reduceSP());

            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");

            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");

            commands.add("orw (%A),%D,%D");

            commands.add("movw %D,(%A)");
        }

        else if (command.equals("not")) {
            commands.add("; NOT");

            commands.addAll(reduceSP());

            commands.add("movw (%A),%D");

            commands.add("notw %D");

            commands.add("movw %D,(%A)");

            commands.addAll(increaseSP());
        }
        else {
                Error.error("Instrução invalida");
        }

            String[] stringArray = new String[ commands.size() ];
            commands.toArray( stringArray );
            write(stringArray);
        }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando de Push ou Pop.
     * @param  command comando de push ou pop a ser analisado.
     * @param  segment segmento de memória a ser usado pelo comando.
     * @param  index índice do segmento de memória a ser usado pelo comando.
     */
    public void writePushPop(Parser.CommandType command, String segment, Integer index) {
        List<String> commands = new ArrayList<String>();
        //instruções do tipo: push constant 8
        if(command == Parser.CommandType.C_PUSH){
            if(segment.equals("constant")){

                //Constante (int) para string
                String constant = Integer.toString(index);
                commands.add("leaw $"+ constant +" ,%A");

                commands.add("movw %A,%D");

                commands.add("leaw $SP,%A");
                commands.add("movw (%A),%A");

                commands.add("movw %D,(%A)");

                commands.addAll(increaseSP());


            }
        }
        String[] stringArray = new String[ commands.size() ];
        commands.toArray( stringArray );
        write(stringArray);
    }


    /**
     * Armazena o nome do arquivo vm de origem.
     * Usado para definir os dados estáticos do código (por arquivo).
     * @param file nome do arquivo sendo tratado.
     */
    public void vmfile(String file) {
        int i = file.lastIndexOf(File.separator);
        int j = file.lastIndexOf('.');
        this.filename= file.substring(i+1,j);
    }

    // grava as instruções em Assembly no arquivo de saída
    public void write(String[] stringArray) {
        // gravando comandos no arquivos
        for (String s: stringArray) {
            this.outputFile.println(s);
        }
    }

    // fecha o arquivo de escrita
    public void close() throws IOException {
        this.outputFile.close();
    }


}
