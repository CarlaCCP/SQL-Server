use guia_sql;
GO

CREATE TABLE clientes (
	nome varchar(100),
	idade tinyint,
	profissao varchar(100)
);

create table aluno (
	
	matricula int IDENTITY (500, 1),
	nome varchar(20) not null,
	meioNome varchar(20),
	sobrenome varchar(30)
);

create table aluno1 (
Matricula int not null identity(1,1),
	nome varchar(20) not null,
	meioNome varchar(20),
	sobrenome varchar(30),
	constraint pkAluno primary key (matricula)

);

create table prova (
id int not null identity(1,1),
matricula int not null,
nota decimal(4,2) not null,
constraint pkProva primary key (id),
constraint fkProva foreign key(matricula)
references aluno1(matricula)

); 

create table Cliente (
 numCliente int not null IDENTITY(1,1),
 cpf int not null,
 rg int not null,
 constraint pkCliente primary key (numCliente),
 constraint uqClienteCPF unique (cpf),
 constraint uqClienteRg unique (rg)

);

create table Venda (
 dataVenda date not null constraint dfdataVenda default (getdate()),
 numeroCliente int not null constraint dfQtd default (1),
 constraint pkVenda primary key (dataVenda),
 constraint fkVenda foreign key (numeroCliente)
 references Cliente(numCliente),

);


CREATE TABLE Pessoa
(
idCliente smallint identity(-32767, 1), 
Telefone VARCHAR(14), 
DataEntrada datetime,
Idade tinyint not null,
constraint ckIdade CHECK (Idade between 18 and 90),
constraint ckTelefone CHECK
(Telefone LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
OR
Telefone LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-
9]')
);

alter table Pessoa add teste varchar (100);
alter table aluno1 alter column nome varchar(50) null;
alter table Cliente drop column cpf;
drop table Pessoa;