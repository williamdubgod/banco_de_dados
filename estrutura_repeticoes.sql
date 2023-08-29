set serveroutput on
//loop
declare
    v_contador number(2):= 1;
begin
loop
    dbms_output.put_line(v_contador);
    v_contador := v_contador + 1;
    exit when v_contador > 20;
end loop;
end;

//while loop
declare
    v_contador number(2):= 1;
begin
while v_contador <= 20 loop 
    dbms_output.put_line(v_contador);
    v_contador := v_contador + 1;
end loop;
end;

//for loop
begin
for v_contador in 1..20 loop
    dbms_output.put_line(v_contador);
end loop;
end;

//for-reverse loop
begin
for v_contador in reverse 1..20 loop
    dbms_output.put_line(v_contador);
end loop;
end;

//exercicios

//loop
declare
    v_tabu number(3) := &tabuadas;
    v_cont number(2) := 0;
begin
    loop
        dbms_output.put_line(v_tabu||' X '||v_cont||' = '||(v_tabu * v_cont));
        v_cont := v_cont + 1;
        exit when v_cont > 10;
    end loop;
end;

//while
declare
    v_tabu number(3) := &tabuadas;
    v_cont number(2) := 0;
begin
while v_cont <= 10 loop 
    dbms_output.put_line(v_tabu||' X '||v_cont||' = '||(v_tabu * v_cont));
    v_cont := v_cont + 1;
end loop;
end;

//for 
declare
    v_tabu number(3) := &tabuadas;
begin
for v_cont in 1..10 loop
    dbms_output.put_line(v_tabu||' X '||v_cont||' = '||(v_tabu * v_cont));
end loop;
end;

//exercicio 2
declare 
    v_digito number(3) := &digito;
    v_cont number(2) := 0;
    v_par number(3) := 0;
    v_impar number(3) := 0;
begin
while v_cont <= v_digito loop
        IF MOD(v_cont, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('O número ' || v_cont || ' é PAR');
            v_par := v_par + 1;
        ELSE
            DBMS_OUTPUT.PUT_LINE('O número ' || v_cont || ' é ÍMPAR');
            v_impar := v_impar + 1;
        END IF; 
    v_cont := v_cont + 1;
    
end loop;
DBMS_OUTPUT.PUT_LINE('Quantidade de numeros pares: ' || v_par);
DBMS_OUTPUT.PUT_LINE('Quantidade de numeros impares: ' || v_impar);
end;


