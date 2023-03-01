Introdução a línguagem SQL
DDL - Línguagem de definição de dados - Estrutura 
Criando tabelas
Sintaxe:
    create table nome_tabela
    (nome_coluna1 tipo_dados(tamanho) [regra],
    ......,
    nome_colunaN tipo_dados (tamanho [regra]);
    
Tipo de dados: char(n), campo alfanumérico de tamanho fixo
               varchar(n), campo alfanumérico de tamanho variável
               number(x,y), campo númerico inteiro ou real
               date, campo tipo data
n = tamanho
x = parte inteira
y = parte real casas decimais

Regras/Constraints 
Pk - primary key, campo unico, preenchimento obrigatório, relacionamento
Fk - foreign key, relacionamento lado n da cardinalidade, recebe dados 
     previamentes cadastrados na Pk
Nn - not null, campo de preenchimento obrigatório
Uk - unique, campo com restrição a dados repetidos
Ck - check, campo com lista de dados para validação

Exemplificando

1- Criando uma tabela sem regras:

create table cargo
(cd_cargo number(3),
nm_cargo varchar2(25),
salario number(8,2));

visualizando a estrutura de uma tabela
desc nome_tabela

Exemplo:
desc cargo

select object_name from user_objects where object_type = 'TABLE';

Deletado uma tabela
drop table nome_tabela

Exemplo:
drop table cargo

2- Criando uma tabela com regras, sem personalização:
create table cargo
(cd_cargo number(3) primary key,
nm_cargo varchar2(25)not null unique,
salario number(8,2));

desc cargo

Visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO'

3- Criando uma tabela com regras, com personalização:

drop table cargo

create table cargo
(cd_cargo number(3) constraint cargo_cd_pk primary key,
nm_cargo varchar2(25)constraint cargo_nome_nn not null
                     constraint cargo_nome_uk unique,
salario number(8,2));

desc cargo

Visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO'

criando o relacionamento

1 - 1 - Pk + FK_UK
1 - N - Pk + FK
N - N - não existe em código SQL

desc cargo

create table funcionario
(cd_fun number(3) constraint fun_cd_pk primary key,
nm_fun varchar(30) constraint fun_nm_nn not null,
dt_adm date constraint fun_dt_nn not null,
uf_fun char(2) constraint fun_uf_nn not null,
cargo_fk number(3) constraint fun_cargo_fk references cargo)

desc funcionario

create table funcionario2
(cd_fun number(3) constraint fun_cd_pk2 primary key,
nm_fun varchar(30) constraint fun_nm_nn2 not null,
dt_adm date constraint fun_dt_nn2 not null,
uf_fun char(2) constraint fun_uf_nn2 not null,
cargo_fk references cargo)

create table n_fiscal
(n_nf number(5) constraint nf_cd_pk primary key,
dt_nf date constraint nf_dt_nn not null,
total_nf number(10,2));

desc n_fiscal
select constraint_name, constraint_type from user_constraints where table_name = 'N_FISCAL'

create table produto
(cd_pro number(5) constraint prod_cd_pk primary key,
nm_prod varchar2(30) constraint prod_mn_nn not null
constraint prod_nm_uk unique,
preco number(10, 2))

select constraint_name, constraint_type from user_constraints where table_name = 'PRODUTO'

create table tem
(fk_nota number(5) constraint tem_nf_fk references n_fiscal,
fk_prod number(5) constraint tem_prod_fk references produto)

Inserindo dados 
Comando DML - Data Manipulation Language
Novas linhas:
insert into nome_tabela values
(valor1, valor2,..., valorN)

Obs: campos: char, varchar ou varchar2 e date precisam de apóstrofe

Exemplo 1
conhecendo ou visualizando a estrutura 
desc n_fiscal
inserindo uma linha
insert into n_fiscal values (1,'10-jan-00',5000);
insert into n_fiscal values (2,'10-Dec-00',5000);
verificando a inserção
select * from n_fiscal

descobrindo o padrão da data
select sysdate from dual

gravando dados fisicamente
commit;

Aula 03 - 01/03/2023

Ainda trabalhando com estruturas das tabelas

DDL

Create - Ok

Alterando ou corrigindo uma estrutura
alter table nome_tabela
opções
add column          - nova coluna
add constraint      - nova regra
modify              - modifica tipo e/ou tamanho de uma coluna
drop column         - elimina uma coluna
drop constraint     - elimina uma regra

create table tb_teste
(codigo number(2),
nome number(10));

incluindo uma nova coluna
alter table tb_teste add dt_nasc date

incluindo uma coluna com regra
alter table tb_teste add cep char(8) not null

incluindo a pk na coluna codigo
alter table tb_teste add constraint pk_cod primary key (codigo)

modificando apenas o tipo de dado
alter table tb_teste modify nome varchar(10)

modificando apenas o tamanho da coluna
alter table tb_teste modify nome varchar(50)

modificando o tamanho da coluna e o tipo ao mesmo tempo
alter table tb_teste modify nome number(10)

eliminando uma regra
alter table tb_teste drop constraint pk_cod
desc user_constraints
select constraint_name from user_constraints where table_name = 'TB_TESTE'

Eliminando uma coluna
alter table tb_teste drop column nome

Renomeando uma coluna
alter table tb_teste rename column codigo to cod_cliente

Renomeando uma constraint 
alter table tb_teste rename constraint SYS_C003509438 to fiap
select constraint_name from user_constraints where table_name = 'TB_TESTE'

eliminando uma tabela 
drop table nome_tabela
drop table tb_teste
desc cargo

create table tb_teste1
(codigo number(1) primary key)
create table tb_teste2
(codigo number(1) references tb_teste1)
insert into tb_teste1 values(1)
insert into tb_teste2 values(1)

uso do cascade permite eliminar o relacionamento e depois dropar a tabela
drop table tb_teste1 cascade constraints

Atualizando dados

Update atualiza os dados, já o alter table atualiza a tabela e suas caracteristicas

operadores: aritiméticos: + - * / ()
            relacionais: > >= < <= = != ou <>
            lógicos: and or not

update nome_tabela set nome_coluna = novo_valor

update nome_tabela set nome_coluna = novo_valor
where condição

pegar o resto da aula no site



