/**
 * Curso: Elementos de Sistemas
 * Arquivo: Parser.java
 */

package assembler;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


/**
 * Encapsula o cÃ³digo de leitura. Carrega as instruÃ§Ãµes na linguagem assembly,
 * analisa, e oferece acesso as partes da instruÃ§Ã£o  (campos e sÃ­mbolos).
 * AlÃ©m disso, remove todos os espaÃ§os em branco e comentÃ¡rios.
 */
public class Parser 
{

    /** Enumerator para os tipos de comandos do Assembler. */
    public enum CommandType 
    {
        A_COMMAND,      // comandos LEA, que armazenam no registrador A
        C_COMMAND,      // comandos de calculos
        L_COMMAND       // comandos de Label (sÃ­mbolos)
    }

    private SymbolTable symbolTable;
    String currentCommand;
    
    
    
    
    BufferedReader br;
    
    /**
     * Abre o arquivo de entrada NASM e se prepara para analisÃ¡-lo.
     * @param file arquivo NASM que serÃ¡ feito o parser.
     */
    public Parser(String file) 
    {
    	
    	symbolTable = new SymbolTable();
        try 
        {
        	System.out.println("Working Directory = " +
                    System.getProperty("user.dir"));

        	//int i = 0;

        	try (BufferedReader br_1p = new BufferedReader(new FileReader(file))) 
        	{
        	    String line;
        	    int i = 0;
        	    while ((line = br_1p.readLine()) != null) 
        	    {
        	    	if (line.indexOf(';') == 0 || line.isEmpty() )
        	  {
                        //i += 1;
              }  else if (line.contains(":"))
                {
                    	line = line.split(":")[0];
                    	System.out.println("SS"+line);
                    	
                    if (!symbolTable.contains(line)) 
                    	{
                         symbolTable.addEntry(line,i);
                         System.out.println("SS"+line);
                        }
               } else 
                    {
                    	i++;
                    }
        	       System.out.println(line);// process the line.
        	    }
        	}

        	br = new BufferedReader(new FileReader(file));


        } catch (Exception e)
        { 
            e.printStackTrace();
        }

        //currentCommand = "";

    }


    /**
     * Carrega uma instruÃ§Ã£o e avanÃ§a seu apontador interno para o prÃ³xima
     * linha do arquivo de entrada. Caso nÃ£o haja mais linhas no arquivo de
     * entrada o mÃ©todo retorna "Falso", senÃ£o retorna "Verdadeiro".
     * @return Verdadeiro se ainda hÃ¡ instruÃ§Ãµes, Falso se as instruÃ§Ãµes terminaram.
     */
    public boolean advance()
    {
    	try {
			currentCommand = br.readLine();
			} catch (IOException e) 
    	{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		System.out.println(currentCommand);

    	if(currentCommand==null)
    	{
    		return false;
    	}

			if (currentCommand.trim().isEmpty())
		{
				return advance();
		}

			if (currentCommand.charAt(0) == ';')
		{
				return advance();
		}

    	return true;
    }

    
    /**
     * Retorna o comando "intruÃ§Ã£o" atual (sem o avanÃ§o)
     * @return a instruÃ§Ã£o atual para ser analilisada
     */
    public String command() 
    {
    	return currentCommand;
    }

    /**
     * Retorna o tipo da instruÃ§Ã£o passada no argumento:
     *  A_COMMAND para leaw, por exemplo leaw $1,%A
     *  L_COMMAND para labels, por exemplo Xyz: , onde Xyz Ã© um sÃ­mbolo.
     *  C_COMMAND para todos os outros comandos
     * @param  command instruÃ§Ã£o a ser analisada.
     * @return o tipo da instruÃ§Ã£o.
     */
    public CommandType commandType(String command) {
        // l == leaw==instrucao do tipo A

        // Search String - ":" Label
        if (command.contains(":")){
            return CommandType.L_COMMAND;
        }
        for (int i = 0; i < command.length(); i++) {
            Character each = command.charAt(i);

            if (each == 'l') {

                return CommandType.A_COMMAND;
            }

            if (each != 'l' && each != ' ') {
                return CommandType.C_COMMAND;
            }
        }
            return null;
    }



    /**
     * Retorna o sÃ­mbolo ou valor numÃ©rico da instruÃ§Ã£o passada no argumento.
     * Deve ser chamado somente quando commandType() Ã© A_COMMAND.
     * @param  command instruÃ§Ã£o a ser analisada.
     * @return somente o sÃ­mbolo ou o valor nÃºmero da instruÃ§Ã£o.
     */
    public String symbol(String command) 
    {
    	String s = command;



                String symbol = s.replace("leaw", "");

                symbol = symbol.replace("%A", "");

                symbol = symbol.replace(",", "");

                symbol = symbol.replace("$", "");

                symbol = symbol.replace(" ", "");

        System.out.println("!"+symbol);

                return symbol;
    }


    


    /**
     * Retorna o sÃ­mbolo da instruÃ§Ã£o passada no argumento.
     * Deve ser chamado somente quando commandType() Ã© L_COMMAND.
     * @param  command instruÃ§Ã£o a ser analisada.
     * @return o sÃ­mbolo da instruÃ§Ã£o (sem os dois pontos).
     */
    
    // Comandos sem ':'
    public String label(String command) {
    	if (command.indexOf(":") !=0)
    		
    	{
            return command.replace(":","");
            
        }
      	return null;
    }

    /**
     * Separa os mnemÃ´nicos da instruÃ§Ã£o fornecida em tokens em um vetor de Strings.
     * Deve ser chamado somente quando CommandType () Ã© C_COMMAND.
     * @param  command instruÃ§Ã£o a ser analisada.
     * @return um vetor de string contento os tokens da instruÃ§Ã£o (as partes do comando).
     */
    public String[] instruction(String command) 
    {
        command = command.replace(" ", "");
        String[] instructionCode = command.split(" ");

     	if (instructionCode.length <= 1)
    {
     		return instructionCode;
   	}
   	else 
   	{
   		String[] secondParts = instructionCode[1].split(",");
   		
   		List<String> answer = new ArrayList<String>();
   		
   		answer.add(instructionCode[0]);
   		
   		for(int i = 0; i < secondParts.length; i++)
   		{
   			answer.add(secondParts[i]);
   		}
   		String[] instruction = new String[answer.size()];
   		
   		instruction = answer.toArray(instruction);
   		
   		return instruction;

   	}
    }

      public SymbolTable getSymbolTable(){
          return symbolTable;
    	
    }

    // fecha o arquivo de leitura
    public void close() throws IOException {
        br.close();
    }

}
