Aula 1 - Introdução blocos anônimos

1º comando a ser executado
Habilitando a saida de dados de um bloco pl

set serveroutput on 

1º Programa

begin
    dbms_output.put_line ('Bloco Ok!!!');
end;

Trabalhando com variáveis 

declare 
    v1 number(2) := 10;
    v2 number(2) := 10;
    re number(3);
begin
    re := v1 + v2;
    dbms_output.put_line(re);
end;

declare 
    v1 number(2) := 15;
    v2 number(2) := 12;
    re number(3) := v1 + v2;
begin
    dbms_output.put_line('resultado: ' ||re);
end;

Entrada de dados via teclado

declare
--declaração de vm
--uso de variaveis de substituição
    v1 number(2) := &Valor_1;
    v2 number(2) := &Valor_2;
--processamento
    re number(3) := v1 + v2;
begin
--saida de dados
    dbms_output.put_line('resultado: ' ||re);
end;
--fim programa

begin 
    dbms_output.put_line('Salario minimo - R$1320,00');
    dbms_output.put_line('Acrescimo de 25%');
    dbms_output.put_line('Novo salario R$ '||1320*1.25||',00');
end