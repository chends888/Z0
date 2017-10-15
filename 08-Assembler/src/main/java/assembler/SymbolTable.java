
package assembler;





import java.util.Hashtable;

/**
 * MantÃ©m uma tabela com a correspondÃªncia entre os rÃ³tulos simbÃ³licos e endereÃ§os numÃ©ricos de memÃ³ria.
 */
public class SymbolTable
{

    /**
     * Cria a tabela de sÃ­mbolos.
     */
		Hashtable<String, Integer> staticSymbols;
    public SymbolTable()
     {
    	
    	staticSymbols = new Hashtable<String, Integer>();
		
 	   staticSymbols.put("R0", 0);
 	   staticSymbols.put("R1", 1);
 	   staticSymbols.put("R2", 2);
 	   staticSymbols.put("R3", 3);
 	   staticSymbols.put("R4", 4);
 	   staticSymbols.put("R5", 5);
 	   staticSymbols.put("R6", 6);
 	   staticSymbols.put("R7", 7);
 	   staticSymbols.put("R8", 8);
 	   staticSymbols.put("R9", 9);
 	   staticSymbols.put("R10", 10);
 	   staticSymbols.put("R11", 11);
 	   staticSymbols.put("R12", 12);
 	   staticSymbols.put("R13", 13);
 	   staticSymbols.put("R14", 14);
 	   staticSymbols.put("R15", 15);
 	   staticSymbols.put("SP", 0);
 	   staticSymbols.put("LCL", 1);
 	   staticSymbols.put("ARG", 2);
 	   staticSymbols.put("THIS", 3);
 	   staticSymbols.put("THAT", 4);
 	   staticSymbols.put("SCREEN", 16384);
 	   staticSymbols.put("KBD", 24576 );
     	   
     }
    	
   
    /**
     * Insere uma entrada de um sÃ­mbolo com seu endereÃ§o numÃ©rico na tabela de sÃ­mbolos.
     * @param  symbol sÃ­mbolo a ser armazenado na tabela de sÃ­mbolos.
     * @param  address sÃ­mbolo a ser armazenado na tabela de sÃ­mbolos.
     */
    public void addEntry(String symbol, int address) 
    {
    	staticSymbols.put(symbol, address);
    }

    /**
     * Confere se o sÃ­mbolo informado jÃ¡ foi inserido na tabela de sÃ­mbolos.
     * @param  symbol sÃ­mbolo a ser procurado na tabela de sÃ­mbolos.
     * @return Verdadeiro se sÃ­mbolo estÃ¡ na tabela de sÃ­mbolos, Falso se nÃ£o estÃ¡ na tabela de sÃ­mbolos.
     */
    public Boolean contains(String symbol) 
    {
    	
    	if (staticSymbols.containsKey(symbol))
    	{
    		return true;
    	}
    	else{
    		return false;
    		}
    }

    /**
     * Retorna o valor nÃºmerico associado a um sÃ­mbolo jÃ¡ inserido na tabela de sÃ­mbolos.
     * @param  symbol sÃ­mbolo a ser procurado na tabela de sÃ­mbolos.
     * @return valor numÃ©rico associado ao sÃ­mbolo procurado.
     */
    public Integer getAddress(String symbol)
    {
    	
    	return staticSymbols.get(symbol);
    }

}
