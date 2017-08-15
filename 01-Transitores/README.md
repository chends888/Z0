---
title: Elementos de Sistema - Projeto 1 - Transistores 
author: Rafael Corsi - rafael.corsi@insper.edu.br
date: Agosto - 2017
---

Prazo de entrega : 22/8/2017

# Descrição 

Esse projeto tem como objetivo trabalhar com os conceitos básicos de portas lógicas feitas a base de transistores discretos e com circuitos integrados CMOS. Deve ser entregue quatro circuitos eletrônicos sendo  dois baseados em transistores discreto e dois baseados em circuitos integrados CMOS.

# Instruções

Deve-se implementar as portas lógicas com os transistores NMOS e PMOS em uma [protoboard](https://pt.wikipedia.org/wiki/Placa_de_Ensaio) (placa de ensaio) e as equações lógicas devem ser implementados utilizando os circuitos integrados da família 74xx.

## Porta Lógica

Implementar a seguinte porta lógica utilizando os transistores (sugeridos) BS250 (tipo p) e o BS170 (tipo n). Para os dois casos, apresentar uma documentação com o esquemático e uma explicação de como ele funciona.

> NAND
> 
>> Deve-se implementar um NAND com duas entradas e uma saída.
 
> XOR
> 
>> Deve-se implementar um XOR com duas entradas e uma saída.

## Equações lógicas

Implementar as seguintes equações lógicas utilizando circuitos integrados discretos da família [74xx](https://pt.wikipedia.org/wiki/Lista_dos_circuitos_integrados_da_s%C3%A9rie_7400).

> Equação 1:
>
>> | A | B | C | Y |
>> |---|---|---|---|
>> | 0 | 0 | 0 | 0 |
>> | 0 | 0 | 1 | 0 |
>> | 0 | 1 | 0 | 1 |
>> | 0 | 1 | 1 | 1 |
>> | 1 | 0 | 0 | 1 |
>> | 1 | 0 | 1 | 1 |
>> | 1 | 1 | 0 | 0 |
>> | 1 | 1 | 1 | 0 |

> Equação 2:
>
>> (NOT A) OR (NOT B) OR (C AND A) OR (C AND (NOT A))



# Avaliação :

## Itens necessários para o aceite

- Ao menos três dos quatro itens entregues.

## Validação

Demonstração da tabela verdade para os dois casos utilizando botões (ou chaves) como entrada e um LED como saída.

## Rubrica

| Nota máxima | Descritivo                                 |
|-------------|--------------------------------------------|
| A           | - Entregue no prazo                        |
|             | - 4 itens corretos                         |
| B           | - Entregue no prazo                        |
|             | - 3 itens corretos e um com pequenos erros |
| C           | - Entregue fora do prazo, ou               |
|             | - Implementando 3 itens corretos           |
| D           | - Menos que 3 itens entregues corretamente |
| I           | - Não entregue                             |



