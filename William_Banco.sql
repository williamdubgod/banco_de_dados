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

create table nota_fiscal
(num_nf char(9) constraint nf_cd_pk primary key,
dt_emissao date constraint nf_dt not null,
total_nf number(1)
