Introdu??o a l?nguagem SQL
DDL - L?nguagem de defini??o de dados - Estrutura 
Criando tabelas
Sintaxe:
    create table nome_tabela
    (nome_coluna1 tipo_dados(tamanho) [regra],
    ......,
    nome_colunaN tipo_dados (tamanho [regra]);
    
Tipo de dados: char(n), campo alfanum?rico de tamanho fixo
               varchar(n), campo alfanum?rico de tamanho vari?vel
               number(x,y), campo n?merico inteiro ou real
               date, campo tipo data
n = tamanho
x = parte inteira
y = parte real casas decimais

Regras/Constraints 
Pk - primary key, campo unico, preenchimento obrigat?rio, relacionamento
Fk - foreign key, relacionamento lado n da cardinalidade, recebe dados 
     previamentes cadastrados na Pk
Nn - not null, campo de preenchimento obrigat?rio
Uk - unique, campo com restri??o a dados repetidos
Ck - check, campo com lista de dados para valida??o

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

2- Criando uma tabela com regras, sem personaliza??o:
create table cargo
(cd_cargo number(3) primary key,
nm_cargo varchar2(25)not null unique,
salario number(8,2));

desc cargo

Visualizando constraints
select constraint_name, constraint_type from user_constraints
where table_name = 'CARGO'

3- Criando uma tabela com regras, com personaliza??o:

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
N - N - n?o existe em c?digo SQL

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

Obs: campos: char, varchar ou varchar2 e date precisam de ap?strofe

Exemplo 1
conhecendo ou visualizando a estrutura 
desc n_fiscal
inserindo uma linha
insert into n_fiscal values (1,'10-jan-00',5000);
insert into n_fiscal values (2,'10-Dec-00',5000);
verificando a inser??o
select * from n_fiscal

descobrindo o padr?o da data
select sysdate from dual

gravando dados fisicamente
commit;

Aula 03 - 01/03/2023

Ainda trabalhando com estruturas das tabelas

DDL

Create - Ok

Alterando ou corrigindo uma estrutura
alter table nome_tabela
op??es
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

Update atualiza os dados, j? o alter table atualiza a tabela e suas caracteristicas

operadores: aritim?ticos: + - * / ()
            relacionais: > >= < <= = != ou <>
            l?gicos: and or not

update nome_tabela set nome_coluna = novo_valor

update nome_tabela set nome_coluna = novo_valor
where condi??o

create table produto_tb 
(cod_prod number(4) constraint prod_cod_pk primary key, 
unidade varchar2(3),descricao varchar2(20),val_unit number(10,2))

insert into produto_tb values ('25','KG','Queijo','0.97');
insert into produto_tb values ('31','BAR','Chocolate','0.87');
insert into produto_tb values ('78','L','Vinho','2.00');
insert into produto_tb values ('22','M','Linho','0.11');
insert into produto_tb values ('30','SAC','Acucar','0.30');
insert into produto_tb values ('53','M','Linha','1.80');
insert into produto_tb values ('13','G','Ouro','6.18');
insert into produto_tb values ('45','M','Madeira','0.25');
insert into produto_tb values ('87','M','Cano','1.97');
insert into produto_tb values ('77','M','Papel','1.05');
commit;

ex:

1- Atualizar em 15% o pre?o dos produtos de codigo maior que 30.
update produto_tb set val_unit = val_unit * 1.15
where cod_prod > 30

2- atualizar o nome do produto queijo para queijo minas.
update produto_tb set descricao = 'Queijo Minas'
where descricao = 'Queijo'

3- para os produtos A?ucar, madeira e linha zerar o pre?o.
update produto_tb set val_unit = 0
where cod_prod = 30 or cod_prod = 45 or cod_prod = 53

select * from produto_tb order by 1

Aula 4 - 08/03/2023 - Finalizando DML

Eliminando linha(s)
todas as linhas:
delete from nome_tabela
algumas linhas:
dele from nome_tabela where condi??o

commit

Apagando tudo:
select * from produto_tb
delete from produto_tb
rollback

delete from produto_tb where cod_prod = 31
Gravando dados em disco: commit
Desfazendo DML: rollback

create table CIDADE(
C?digo number(4) constraint pk_cod primary key,
Nome varchar(30) constraint nome_nn not null);

create table SOCIO(
CPF char(11) constraint pk_cpf primary key,
Nome varchar(20) constraint nome_socio not null,
DataNasc date constraint data_nasc not null,
RG varchar(15) constraint rg_socio not null,
Cidade number(4) references CIDADE not null);

alter table CIDADE add Uf varchar(2) constraint uf_cidade not null;

alter table SOCIO add Fone varchar(10);
alter table SOCIO add Sexo varchar(1) constraint sexo_socio not null;

alter table SOCIO modify Nome varchar(35);

create table SETOR(
Codigo number(3) constraint cod_setor_pk primary key,
Nome varchar(30) constraint nome_setor not null);

alter table SOCIO add Setor number(3) references SETOR constraint cod_setor not null

create table DEPENDENTE(
Socio char(11) references SOCIO constraint socio_dependente not null,
Numero number(4) constraint num_dep_pk primary key,
Nome varchar(30) constraint nm_dep not null,
DataNasc date constraint data_dep not null);

insert into CIDADE values ('0001','S?o Paulo', 'SP');
insert into CIDADE values ('0002','Rio de Janeiro', 'RJ');

insert into SETOR values ('001','ADM');
insert into SETOR values ('002','DEV');

insert into SOCIO values ('37490547890','William', '28-aug-00', '47944004X', '0001', '998631820', 'm', '001');
insert into SOCIO values ('12345678987','Gustavo', '05-may-04', '65487054X', '0002', '', 'f', '002');

insert into DEPENDENTE values ('37490547890', '1111', 'Sergio', '14-aug-57');
insert into DEPENDENTE values ('12345678987', '2222', 'Mario', '19-aug-47');

select * from SETOR

Aula 5 - Correção de exercícios
Ckp 01 - 29/03/2023

create table cidade (codigo number(4) constraint pk_cidade_cd primary key,
nome varchar(30) constraint nn_cidade_nome not null);

insert into cidade values(1, 'São Paulo', 'SP');
insert into cidade values(2, 'Rio de Janeiro', 'RJ');
desc cidade; - visualiza a estrutura da tabela
select * from cidade;  - Exibe os dados da tabela

create table socio (cpf char(11) constraint pk_soc_cpf primary key,
nome varchar(20) constraint nn_soc_nome not null,
data_nasc date constraint dt_soc_dtnasc not null,
rg varchar(15) constraint nn_soc_rg not null,
cidade number(4) constraint fk_soc_cid references cidade)

alter table cidade add uf char(2) constraint nn_cid_uf not null

alter table socio add (fone varchar(10),
sexo char(1) constraint nn_soc_sex not null);

alter table socio modify nome varchar(35)

create table setor (codigo number(3) constraint pk_set_cd primary key,
nome varchar(30) constraint nm_set_nome not null);

alter table socio add setor number(3) not null references setor;

create table dependente (socio char(11) not null references socio,
numero number(4) primary key,
nome varchar(30) not null,
datanasc date not null);

select constraint_name, constraint_type from user_constraints where table_name = 'CIDADE'























