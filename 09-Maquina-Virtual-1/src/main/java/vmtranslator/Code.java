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
    static int retornoCnt = 0;

    /**
     * Abre o arquivo de entrada VM e se prepara para analisá-lo.
     *
     * @param filename nome do arquivo NASM que receberá o código traduzido.
     */
    public Code(String filename) throws FileNotFoundException, IOException {
        File file = new File(filename);
        this.outputFile = new PrintWriter(new FileWriter(file));
    }

    public List<String> reduceSP() {
        List<String> commands = new ArrayList<String>();
        commands.add("leaw $SP,%A");
        commands.add("movw (%A),%D");
        commands.add("decw %D");
        commands.add("movw %D,(%A)");
        return commands;
    }

    public List<String> increaseSP() {
        List<String> commands = new ArrayList<String>();
        commands.add("leaw $SP,%A");
        commands.add("movw (%A),%D");
        commands.add("incw %D");
        commands.add("movw %D,(%A)");
        return commands;
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando aritmético.
     *
     * @param command comando aritmético a ser analisado.
     */
    public void writeArithmetic(String command) {
        if (command.equals("")) {
            Error.error("Instrução invalida");
        }

        List<String> commands = new ArrayList<String>();

        if (command.equals("add")) {
            // Comentário para facilitar o debug:
            commands.add("; ADD");
            commands.addAll(reduceSP());
            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");
            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");
            commands.add("addw (%A),%D,%D");
            commands.add("movw %D,(%A)");

        } else if (command.equals("sub")) {
            commands.add("; SUB");
            commands.addAll(reduceSP());
            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");
            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");
            commands.add("subw (%A),%D,%D");
            commands.add("movw %D,(%A)");
        } else if (command.equals("neg")) {
            commands.add("; NEG");
            commands.addAll(reduceSP());
            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");
            commands.add("negw %D");
            commands.add("movw %D,(%A)");
            commands.addAll(increaseSP());
        } else if (command.equals("gt") || command == "lt" || command == "eq") {

            commands.addAll(reduceSP());
            commands.add("movw %D,%A");
            commands.add("movw (%A),%D");
            commands.add("decw %A");
            commands.add("movw (%A),%A");
            commands.add("subw %D,%A,%D");
            commands.add("movw %D,%A");
            commands.add("LabelTrue:");
            commands.add("leaw $LabelTrue,%A");
            commands.add("leaw $0 ,%A");
            commands.add("notw %A");
            commands.add("movw %A,%D");
            commands.add("leaw $SP ,%A");
            commands.add("movw (%A) ,%A");
            commands.add("decw %A");
            commands.add("movw %D, (%A)");
            commands.add("leaw $LabelEnd,%A");
            commands.add("jl");
            commands.add("nop");

            /**
             * false
             */
            commands.add("LabelFalse:");
            commands.add("leaw $0 ,%A");
            commands.add("movw %A,%D");
            commands.add("leaw $SP ,%A");
            commands.add("movw (%A) ,%A");
            commands.add("decw %A");
            commands.add("movw %D, (%A)");
            commands.add("leaw $LabelEnd,%A");
            commands.add("jl");
            commands.add("nop");
            commands.add("leaw $0,(%A");
            commands.add("leaw $LabelEnd,%A");
            commands.add("je");
            commands.add("nop");
            commands.add("LabelEnd:");
            commands.add("nop");

        } else if (command.equals("and")) {
            commands.add("; AND");
            commands.addAll(reduceSP());
            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");
            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");
            commands.add("andw (%A),%D,%D");
            commands.add("movw %D,(%A)");
        } else if (command.equals("or")) {
            commands.add("; OR");
            commands.addAll(reduceSP());
            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");
            commands.add("leaw $SP,%A");
            commands.add("subw (%A),$1,%A");
            commands.add("orw (%A),%D,%D");
            commands.add("movw %D,(%A)");
            commands.addAll(increaseSP());
        } else if (command.equals("not")) {
            commands.add("; NOT");
            commands.addAll(reduceSP());
            commands.add("movw (%A),%A");
            commands.add("movw (%A),%D");
            commands.add("notw %D");
            commands.add("movw %D,(%A)");
            commands.addAll(increaseSP());
        } else {
            Error.error("Instrução invalida");
        }

        String[] stringArray = new String[commands.size()];
        commands.toArray(stringArray);
        write(stringArray);
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando de Push ou Pop.
     *
     * @param command comando de push ou pop a ser analisado.
     * @param segment segmento de memória a ser usado pelo comando.
     * @param index   índice do segmento de memória a ser usado pelo comando.
     */
    public void writePushPop(Parser.CommandType command, String segment, Integer index) {
        List<String> commands = new ArrayList<String>();
        //instruções do tipo: push constant 8
        if (command == Parser.CommandType.C_PUSH) {
            String constant = Integer.toString(index);

            if (segment.equals("constant")) {
                //Constante (int) para string
                commands.add("leaw $" + constant + ",%A");
                commands.add("movw %A,%D");
                commands.add("leaw $SP,%A");
                commands.add("movw (%A),%A");
                commands.add("movw %D,(%A)");
                commands.addAll(increaseSP());
            } else if (segment.equals("argument") || segment.equals("local") || segment.equals("static")) {
                commands.add("leaw $" + segment + ",%A");
                commands.add("movw %A,%D");
                commands.add("leaw $" + constant + ",%A");
                commands.add("addw %A,%D,%A");
                commands.add("movw (%A),%A");
                commands.add("movw %A,%D");
                commands.add("leaw $SP,%A");
                commands.add("movw (%A),%A");
                commands.add("movw %D,(%A)");

            } else if (segment.equals("temp")) {
                commands.add("leaw $5,%A");
                commands.add("movw $A,%D");
                commands.add("leaw $" + constant + ",%A");
                commands.add("addw %A,%D,%A");
                commands.add("movw (%A),%A");
                commands.add("movw %A,%D");
                commands.add("leaw $SP,%A");
                commands.add("movw (%A),%A");
                commands.add("movw %D,(%A)");
            } else if (segment.equals("that") || segment.equals("this")) {
                commands.add("leaw $" + segment + ",%A");
                commands.add("movw (%A),%A");
                commands.add("movw %A,%D");

            }

        }

        if (command == Parser.CommandType.C_POP) {

            if (segment.equals("argument") || segment.equals("local")) {
                commands.addAll(reduceSP());
                commands.add("movw (%A),%A");
                commands.add("movw (%A),%D");
                commands.add("leaw $" + segment + ",%A");
                commands.add("movw %D,(%A)");
                commands.addAll(reduceSP());
            }


            if (segment.equals("temp")) {
                commands.addAll(reduceSP());
                commands.add("movw (%A),%A");
                commands.add("movw (%A),%D");
                int index2 = 5 + index;
                String constant2 = Integer.toString(index2);
                commands.add("leaw $" + constant2 + ",%A");
                commands.add("movw %D,(%A)");
                commands.addAll(reduceSP());
            }
        }
        String[] stringArray = new String[commands.size()];
        commands.toArray(stringArray);
        write(stringArray);
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para inicializar o processo da VM (bootstrap).
     * Também prepara a chamada para a função Sys.init
     * O código deve ser colocado no início do arquivo de saída.
     */
    public void writeInit() {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar o labels (marcadores de jump).
     *
     * @param label define nome do label (marcador) a ser escrito.
     */
    public void writeLabel(String label) {
        List<String> commands = new ArrayList<String>();
        commands.add(label + ":");

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar as instruções de goto (jumps).
     * Realiza um jump incondicional para o label informado.
     *
     * @param label define jump a ser realizado para um label (marcador).
     */
    public void writeGoto(String label) {
        List<String> commands = new ArrayList<String>();

        commands.add("leaw" + label + ",%A");
        commands.add("movw (%A),%A");
        commands.add("movw %A,%D");
        commands.add("jmp");

        String[] stringArray = new String[commands.size()];
        commands.toArray(stringArray);
        write(stringArray);
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para gerar as instruções de goto condicional (jumps condicionais).
     * Realiza um jump condicional para o label informado.
     *
     * @param label define jump a ser realizado para um label (marcador).
     */
    public void writeIf(String label) {
        List<String> commands = new ArrayList<String>();
        commands.add("leaw $" + label + ", %A");
        commands.add("jne");
        commands.add("nop");

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para uma chamada de função (Call).
     *
     * @param functionName nome da função a ser "chamada" pelo call.
     * @param numArgs      número de argumentos a serem passados na função call.
     */
    public void writeCall(String functionName, Integer numArgs) {
        List<String> commands = new ArrayList<String>();

        /**   String rtnLabel = "RETORNO-"+functionName+"-"+Integer.toString(retornoCnt);

         commands.add("leaw $"+ rtnLabel + ",%A");
         commands.add("leaw %A,%D");
         commands.add("leaw $SP,%A");
         commands.add("movw (%A),%A");
         commands.add("movw %D,(%A)");

         commands.addAll(increaseSP());

         //pushando LCL na pilha
         commands.add("leaw $LCL,%A");
         commands.add("movw %A,%D");
         commands.add("leaw %SP,%A");
         commands.add("movw (%A),%A");
         commands.add("movw %D,(%A)");
         commands.addAll(increaseSP());

         //pushando ARG na pilha
         commands.add("leaw $ARG,%A");
         commands.add("movw %A,%D");
         commands.add("leaw %SP,%A");
         commands.add("movw (%A),%A");
         commands.add("movw %D,(%A)");
         commands.addAll(increaseSP());

         //pushando THIS
         commands.add("leaw $THIS,%A");
         commands.add("movw %A,%D");
         commands.add("leaw %SP,%A");
         commands.add("movw (%A),%A");
         commands.add("movw %D,(%A)");
         commands.addAll(increaseSP());

         //pushando THAT
         commands.add("leaw $THAT,%A");
         commands.add("movw %A,%D");
         commands.add("leaw %SP,%A");
         commands.add("movw (%A),%A");
         commands.add("movw %D,(%A)");
         commands.addAll(increaseSP());



         //redefinindo valor de ARG
         commands.add("leaw $SP,%A");
         commands.add("movw (%A),%A");
         commands.add("movw %A,%D");

         Integer newarg = numArgs + 5;

         commands.add("leaw $"+ Integer.toString(newarg) + "%A");
         commands.add("subw %D,%A,%D");
         commands.add("leaw $ARG,%A");
         commands.add("movw %D,(%A)");

         //redefinindo valor de LCL
         commands.add("leaw $SP,%A");
         commands.add("movw (%A),%A");
         commands.add("movw %A,%D");
         commands.add("leaw $LCL,%A");
         commands.add("movw %D,(%A)");

         writeGoto(rtnLabel);

         commands.add(rtnlabel + ":");

         String[] stringArray = new String[commands.size()];
         commands.toArray(stringArray);
         write(stringArray);

         retornoCnt++;

         */
    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para o retorno de uma sub rotina.
     */
    public void writeReturn() {

            List<String> commands = new ArrayList<String>();
        

            commands.add("leaw $LCL, %A");
            commands.add("movw (%A), %D");
            commands.add("leaw $5, %A");        //FRAME = LCL
            commands.add("movw %D, (%A)");
            commands.add("leaw $5, %A");
            commands.add("subw (%A), $5, %D");
            commands.add("leaw $6, %A");        //RET = *(FRAME-5)
            commands.add("movw %D, (%A)");
            writePushPop(Parser.CommandType.C_POP, "argument", 0); //*ARG = pop()
            commands.add("leaw $ARG, %A");
            commands.add("addw (%A), $1, %D");
            commands.add("leaw %SP, %A");        //SP = ARG+1
            commands.add("movw %D, (%A)");
            commands.add("leaw $5, %A");
            commands.add("subw (%A), $1, %D");
            commands.add("leaw $THAT, %A");        //THAT = *(FRAME-1)
            commands.add("movw %D, (%A)");
            commands.add("leaw $5, %A");
            commands.add("subw (%A), $2, %D");
            commands.add("leaw $THIS, %A");        //THIS = *(FRAME-2)
            commands.add("movw %D, (%A)");
            commands.add("leaw $5, %A");
            commands.add("subw (%A), $3, %D");
            commands.add("leaw $ARG, $A");        //ARG = *(FRAME-3)
            commands.add("movw %D, (%A)");
            commands.add("leaw $5, %A");
            commands.add("subw (%A), $4, %D");
            commands.add("leaw $LCL, %A");        //LCL = *(FRAME-4)
            commands.add("movw %D, (%A)");
            commands.add("leaw $6, %A");
            commands.add("movw (%A), %A");        //goto RET
            commands.add("jmp");


            String[] stringArray = new String[commands.size()];
            commands.toArray(stringArray);
            write(stringArray);

        }

    /**
     * Grava no arquivo de saida as instruções em Assembly para a declaração de uma função.
     * @param  functionName nome da função a ser criada.
     * @param  numLocals número de argumentos a serem passados na função call.
     */
    public void writeFunction(String functionName, Integer numLocals) {
    }

    /**
     * Armazena o nome do arquivo vm de origem.
     * Usado para definir os dados estáticos do código (por arquivo).
     * @param file nome do arquivo sendo tratado.
     */
    public void vmfile(String file) {
        int i = file.lastIndexOf(File.separator);
        int j = file.lastIndexOf(".");
        this.filename = file.substring(i + 1, j);
    }

    // grava as instruções em Assembly no arquivo de saída
    public void write(String[] stringArray) {
        // gravando comandos no arquivos
        for (String s : stringArray) {
            this.outputFile.println(s);
        }
    }

    // fecha o arquivo de escrita
    public void close() throws IOException {
        this.outputFile.close();
    }

}
