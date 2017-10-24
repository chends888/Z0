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
    	    if (mnemnonic [1] == "(%A)"){
    	        return "001";
            }
            else if (mnemnonic [1] == "%D"){
    	        return "010";
            }
            else if (mnemnonic [1] == "%A"){
                return "100";
            }
        }

        else if (mnemnonic.length == 3) {
            if (mnemnonic[2] == "(%A)") {
                return "001";
            } else if (mnemnonic[2] == "%D") {
                return "010";
            } else if (mnemnonic[2] == "%A") {
                return "100";
            }
        }

        else if (mnemnonic.length == 4) {
            if (mnemnonic[3] == "(%A)") {
                return "001";
            } else if (mnemnonic[3] == "%D") {
                return "010";
            } else if (mnemnonic[3] == "%A") {
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
    public static String comp(String[] mnemnonic){

        if (mnemnonic [0] == "movw"){
            if(mnemnonic[1] == "(%A)")
                return "1110000";
            if(mnemnonic[1] == "%D")
                return "0001100";
            if(mnemnonic[1] == "%A")
                return "0110000";
            return "";
        }

        else if (mnemnonic [0] == "addw"){
            // Operação nao permitida
            if(mnemnonic[1] == mnemnonic[2])
                return "";
            // Endereco de A
            if(mnemnonic[1] == "(%A)" || mnemnonic[2] == "(%A)")
                return "1000010";
            // D
            else
                return "0000010";
        }

        else if (mnemnonic [0] == "subw"){
            return "1010011";
        }
        else if (mnemnonic [0] == "rsubw"){
            return "1000111";
        }
        else if (mnemnonic [0] == "incw"){
            return "0011111";
        }
        else if (mnemnonic [0] == "decw"){
            if (mnemnonic[1] == "%D"){
                return "0001110";
            }
            else if (mnemnonic[1] == "%A"){
                return "0110010";
            }
            else {
                return "1110010";
            }
        }
        else if (mnemnonic [0] == "notw"){
            if (mnemnonic[1] == "%D"){
                return "0001101";
            }
            else if (mnemnonic[1] == "%A"){
                return "0110001";
            }
            else if (mnemnonic[1] == "(%A)"){
                return "1110001";
            }
        }
        else if (mnemnonic [0] == "negw"){
            if (mnemnonic[1] == "%D"){
                return "0001111";
            }
            else if (mnemnonic[1] == "%A"){
                return "0110011";
            }
            else{
                return "1110011";
            }
        }
        else if (mnemnonic [0] == "andw"){
            if (mnemnonic[1] == "%A" || mnemnonic[2] == "%A"){
                return "0000000";
            }
            else{
                return "1000000";
            }
        }
        else if (mnemnonic [0] == "orw"){
            if (mnemnonic[1] == "%A"|| mnemnonic[2] == "%A"){
                return "0010101";
            }
            else{
                return "1010101";
            }
        }
        else if (mnemnonic [0] == "nop"){
            return "0101010";
        }

        else if (mnemnonic [0] == "jmp"){
            return "0001100";
        }

        else if (mnemnonic [0] == "je"){
            return "0001100";
        }
        else if (mnemnonic [0] == "jne"){
            return "0001100";
        }
        else if (mnemnonic [0] == "jg"){
            return "0001100";
        }
        else if (mnemnonic [0] == "jl"){
            return "0001100";
        }
        else if (mnemnonic [0] == "jle"){
            return "0001100";
        }
        else if (mnemnonic [0] == "jge"){
            return "0001100";
        }

        return null;
    }



    /**
     * Retorna o código binário do mnemônico para realizar uma operação de jump (salto).
     * @param  mnemnonic vetor de mnemônicos "instrução" a ser analisada.
     * @return Opcode (String de 3 bits) com código em linguagem de máquina para a instrução.
     */
    public static String jump(String[] mnemnonic) {
        if (mnemnonic [0] == "jmp"){
            return "111";
        }

        else if (mnemnonic [0] == "je"){
            return "010";
        }
        else if (mnemnonic [0] == "jne"){
            return "101";
        }
        else if (mnemnonic [0] == "jg"){
            return "001";
        }
        else if (mnemnonic [0] == "jl"){
            return "100";
        }
        else if (mnemnonic [0] == "jle"){
            return "110";
        }
        else if (mnemnonic [0] == "jge"){
            return "011";
        }

    	return "000";
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
