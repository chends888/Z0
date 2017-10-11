/**
 * Curso: Elementos de Sistemas
 * Arquivo: AssemblerZ0.java
 */

package assembler;

/**
 * Classe principal que orquestra execução do Assembler.
 * Opções:
 *   <arquivo nasm>          primeiro parametro é o nome do arquivo nasm a ser aberto 
 *   -o <arquivo binario>    parametro indica onde será salvo o arquivo gerado .mif
 *   -d                      ativa modo verborragico
 *   -h                      exibe a ajuda
 */
class AssemblerZ0 {

    public static void main(String[] args) {

        String help = "file.nasm -o outFile{.hack .mif} -d debug -h help";

        if (args.length < 2) {  // checa se arquivo foi passado
            System.out.println(help);
            System.exit(01);
        }

        String  inputFile        = null;
        String  outputFile       = null;
        String  outputFileHack   = null;
        String  outputFileMif    = null;
        boolean debug            = false;

        for (int i = 0; i < args.length; i++)
            switch (args[i].charAt(0)) {
                case '-':
                    if (args[i].charAt(1) == 'h') {
                        System.out.println(help);
                        break;
                    } else if (args[i].charAt(1) == 'i'){
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

        if(inputFile == null || outputFile == null){
            System.out.println("-i / -o");
            System.exit(02);
        }
        outputFileHack = outputFile.concat(".hack");
        outputFileMif  = outputFile.concat(".mif");

        System.out.printf("-i = %s, -o = %s , %s", inputFile, outputFileHack, outputFileMif);

        Parser parser = new Parser(inputFile);
        // Varre todos as linhas
        do {
            System.out.println(parser.command());
        }while (parser.advance());
    }
}
