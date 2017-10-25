/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package vmtranslator;

/** 
 * Traduz da linguagem vm para códigos assembly.
 */
public class Code {

    /** 
     * Abre o arquivo de entrada VM e se prepara para analisá-lo.
     * @param filename nome do arquivo NASM que receberá o código traduzido.
     */
    public Code(String filename) {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando aritmético.
     * @param  command comando aritmético a ser analisado.
     */
    public void writeArithmetic(String command) {

    }

    /**
     * Grava no arquivo de saida as instruções em Assembly para executar o comando de Push ou Pop.
     * @param  command comando de push ou pop a ser analisado.
     * @param  segment segmento de memória a ser usado pelo comando.
     * @param  index índice do segmento de memória a ser usado pelo comando.
     */
    public void writePushPop(Parser.CommandType command, String segment, Integer index) {

    }


    /**
     * Armazena o nome do arquivo vm de origem.
     * Usado para definir os dados estáticos do código (por arquivo).
     * @param file nome do arquivo sendo tratado.
     */
    public void vmfile(String file) {
    }

}
