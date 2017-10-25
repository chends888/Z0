/**
 * Curso: Elementos de Sistemas
 * Arquivo: VMTranslator.java
 */

package vmtranslator;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.DirectoryStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;


/**
 * Classe principal que orquestra a tradução do arquivo em linguagem de máquina virtual à pilha.
 * Opções:
 * <arquivo vm>         primeiro parâmetro é o nome do arquivo vm a ser aberto
 * -o <arquivo nasm>    parâmetro indica onde será salvo o arquivo gerado .nasm
 * -n                   parâmetro indica não colocar rotina de bootstrap (conveniente para testar)
 */
class VMTranslator {

    static String inputFilename = null;
    static String outputFilename = null;
    static boolean debug = false;
    static boolean bootstrap = true;
    static ArrayList<String> files = new ArrayList<String>();

    public static void error(String message) {
        System.err.println("Erro: " + message);
    }

    static private void argsParser(String[] args) {
        for (int i = 0; i < args.length; i++) {
            switch (args[i].charAt(0)) {
                case '-':
                    if (args[i].charAt(1) == 'h') {
                        System.out.println("Opções");
                        System.out.println("<arquivo> : programa em linguagem de máquina virtual a ser carregado");
                        System.out.println("-o <arquivo> : nome do arquivo para salvar no formato NASM");
                        System.out.println("-n : não colocar rotina de bootstrap (conveniente para testar)");

                    } else if (args[i].charAt(1) == 'o') {
                        outputFilename = args[i + 1]; // arquivo output
                        i++;
                    } else if (args[i].charAt(1) == 'n') {
                        bootstrap = false; // não insere rotina de bootstrap
                    } else {
                        error("Argumento não reconhecido: " + args[i]);
                    }
                    break;
                default:
                    inputFilename = args[i];
                    break;
            }
        }
    }

    static private int loadDirOrFileToFiles( ) throws FileNotFoundException, IOException {

        Path path = new File(inputFilename).toPath().toAbsolutePath();
        // Cria um arquivo de saída dependendo se diretório.
        if (Files.isDirectory(path)) {
            int indexName = path.getNameCount() - 1;
            if (path.getName(indexName).toString().equals(".")) {
                indexName--;
            }

            if (outputFilename == null) {
                outputFilename = path.toString() +
                        File.separator +
                        path.getName(indexName).toString() + ".nasm";
            }

            DirectoryStream<Path> directoryStream = Files.newDirectoryStream(path);
            for (Path p : directoryStream) {

                String extension = "";
                int i = p.toString().lastIndexOf('.');
                if (i > 0) {
                    extension = p.toString().substring(i + 1);
                }
                if (extension.equals("vm")) {
                    files.add(p.toString());
                }
            }
        } else {
            files.add(inputFilename);
            if (outputFilename == null) {
                outputFilename = inputFilename.substring(0, inputFilename.lastIndexOf('.')) + ".nasm";
            }
        }
        return (files.size());
    }

    public static void main(String[] args) {

        if (args.length < 1)  // checa se arquivo foi passado
            System.out.println("informe o nome ou pasta dos arquivos vm");
            System.exit(0);

        argsParser(args);

        try {
            int nFiles = loadDirOrFileToFiles();
            System.out.printf("Localizado %d arquivos . nasm \n inicializando conversão. ", nFiles);

        } catch (FileNotFoundException e) {
            error("Arquivo \'" + inputFilename + "\' nao encontrado");
            System.exit(1);
        } catch (IOException e) {
            error("uma excessao de i/o foi lancada");
            System.exit(1);
        }
    }

}


