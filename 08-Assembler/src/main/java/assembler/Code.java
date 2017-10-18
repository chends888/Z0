/**
 * Curso: Elementos de Sistemas
 * Arquivo: Code.java
 */

package assembler;

/** 
 * Traduz mnemônicos da linguagem assembly para códigos binários da arquitetura Z0.
 */
public class Code {

    /**
     * Retorna o código binário do(s) registrador(es) que vão receber o valor da instrução.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String dest(String[] mnemnonic) {
    	if (mnemnonic.length == 2){
    	    if (mnemonic [1] == "(%A)"){
    	        return "001";
            }
            else if (mnemonic [1] == "%D"){
    	        return "010";
            }
            else if (mnemonic [1] == "%A"){
                return "100";
            }
        }

        else if (mnemonic.lenght == 3) {
            if (mnemonic[2] == "(%A)") {
                return "001";
            } else if (mnemonic[2] == "%D") {
                return "010";
            } else if (mnemonic[2] == "%A") {
                return "100";
            }
        }

        else if (mnemonic.lenght == 4) {
            if (mnemonic[3] == "(%A)") {
                return "001";
            } else if (mnemonic[3] == "%D") {
                return "010";
            } else if (mnemonic[3] == "%A") {
                return "100";
            }
        }
        return null;
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de cálculo.
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 7 bits) com código em linguagem de máquina para a instrução.
     */
    public static String comp(String[] mnemnonic) {

        if (mnemonic [0] == "movw"){
            return "1110000";
        }

        else if (mnemonic [0] == "addw"){
            return "1000010";
        }
        else if (mnemonic [0] == "subw"){
            return "1010011";
        }
        else if (mnemonic [0] == "rsubw"){
            return "1000111";
        }
        else if (mnemonic [0] == "incw"){
            return "0011111";
        }
        else if (mnemonic [0] == "decw"){
            return "1110010";
        }
        else if (mnemonic [0] == "notw"){
            return "0001101";
        }
        else if (mnemonic [0] == "negw"){
            return "0110011";
        }
        else if (mnemonic [0] == "andw"){
            return "0000000";
        }
        else if (mnemonic [0] == "orw"){
            return "1010101";
        }
        else if (mnemonic [0] == "nop"){
            return "0101010";
        }


        return null;
    }

    /**
     * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String jump(String[] mnemnonic) {
        if (mnemonic [0] == "jmp"){
            return "111";
        }

        else if (mnemonic [0] == "je"){
            return "010";
        }
        else if (mnemonic [0] == "jne"){
            return "101";
        }
        else if (mnemonic [0] == "jg"){
            return "001";
        }
        else if (mnemonic [0] == "jl"){
            return "100";
        }
        else if (mnemonic [0] == "jle"){
            return "110";
        }
        else if (mnemonic [0] == "jge"){
            return "011";
        }

    	return null;
    }

    /**
     * Retorna o código binário de um valor decimal armazenado numa String.
     * @param  symbol valor numérico decimal armazenado em uma String.
     * @return Valor em binário (String de 15 bits) representado com 0s e 1s.
     */
    public static String toBinary(String symbol) {
    	return null;
    }

}
