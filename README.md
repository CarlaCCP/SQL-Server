# SQL-Server
Guia para estudo da disciplina Linguagem SQL

As instruções para definições de dados são classificadas como pertencentes a sub-linguagem 

- DDL (Data Definition Language – Linguagem de Definição dos Dados).  Comandos criação, alteração ou eliminação de objetos fazem parte da categoria.

- DML (Data Manipulation Language – Linguagem de Manipulação de Dados) 
- DQL (Data Query Language – Linguagem de Consulta de Dados).

**Tipos de Dados** 

Categorias:

- Numéricos exatos

  - TinyInt  (0 - 225) (Bytes: 1)
  - SMALLINT (-32.768 a 32.767) (Bytes: 2)
  - INT (-231(-2.147.483.648) a 231 (2.147.483.647)) (Bytes: 4)
  - BIGINT (-263 a 263) (Bytes: 8)

- Numéricos aproximados

  - DECIMAL  e NUMERIC (-1038 + 1 a 1038 – 1 (quando a precisão máxi-
    ma é utilizada)) (5 à 17, dependendo da preci-
    são)
  - money (-922.337.203.685.477,5808 a
    922.337.203.685.477,50807) (Bytes: 8)
  - smallmoney (-214.748,3648 a 214.748,3647) (Bytes: 4)

- Data e hora

- Cadeias de caracteres (string) 

  - char(n) (1 a 8000 caracteres) (Bytes: n bytes sempre)
  - varchar(n) (1 a 8000 caracteres) (Bytes: Número de caracteres da cadeia + 2 bytes (Má-
    ximo de n + 2 bytes))
  - varchar(max) (1 a 231 – 1 caracteres) (Bytes: Número de caracteres da cadeia + 2 bytes)

- Cadeia e caracteres Unicode (string Unicode)

  - Uma coluna definida como Unicode é

    independente da codificação utilizada na colação do banco de dados, permitindo então utilizar cadeias escritas em
    qualquer linguagem. A desvantagem desse tipo de dados é que ao invés de utilizar 1 byte por caractere é que utiliza
    2 bytes por caractere. Se usarmos um tipo de dado Unicode onde não é necessário, por exemplo, uma cadeia sempre

    escrita em inglês, estaríamos desperdiçando espaço de armazenamento.

- Binários

**Criando tabelas**

- Gerando um identificador 

  - IDENTITY(Seed, Increment) (1, 1)

    Em que Seed representará o primeiro número a ser gerado pela série, e INCREMENT significa de quanto em quanto os próximos números serão gerados. 

```
create table aluno (
	
	matricula int IDENTITY (500, 1),
	nome varchar(20) not null,
	meioNome varchar(20),
	sobrenome varchar(30)
);

```

- Criando primary key 

```
create table aluno1 (
Matricula int not null identity(1,1),
	nome varchar(20) not null,
	meioNome varchar(20),
	sobrenome varchar(30),
	constraint pkAluno primary key (matricula)

);
```

- Foreign key 

```
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
```

- Unicidade

```
create table Cliente (
 numCliente int not null IDENTITY(1,1),
 cpf int not null,
 rg int not null,
 constraint pkCliente primary key (numCliente),
 constraint uqClienteCPF unique (cpf),
 constraint uqClienteRg unique (rg)

);
```

- Valor Padrão

  Ao definir uma coluna podemos definir um valor padrão (DEFAULT) que será usado quando não for passado um valor para essa coluna na inserção de dados. Não podem fazer referência a uma outra coluna da tabela, ou a outras tabelas, exibições ou procedimentos armazenados.


```
create table Venda (
 dataVenda date not null constraint dfdataVenda default (getdate()),
 numeroCliente int not null constraint dfQtd default (1),
 constraint pkVenda primary key (dataVenda),
 constraint fkVenda foreign key (numeroCliente)
 references Cliente(numCliente),

);
```

- Verificação de valores

A avaliação do critério de pesquisa deve usar uma expressão Booleana (true/false) como base e não pode fazer referência a outra tabela. A restrição CHECK no nível de coluna pode fazer referência somente à coluna restrita. Restrições CHECK oferecem a mesma função de validação dos dados durante instruções INSERT e UPDATE. Se existirem uma ou mais restrições CHECK para uma coluna, todas as restrições serão avaliadas.

```
CONSTRAINT ckIdade CHECK (Idade <= 100)
```

```
CONSTRAINT ckTaxa CHECK (Taxa >= 1 and Taxa <= 5)
```

```
CONSTRAINT CK_emp_id CHECK (emp_id LIKE ‘[A-Z][A-Z][A-Z][1-9][0-9][0-9][0-9]
[0-9][FM]’ OR emp_id LIKE ‘[A-Z]-[A-Z][1-9][0-9][0-9][0-9][0-9][FM]’)
```

```
CONSTRAINT CK_emp_id CHECK (emp_id IN (‘1389’, ‘0736’, ‘0877’, ‘1622’, ‘1756’)
OR emp_id LIKE ‘99[0-9][0-9]’)
```

Exemplo:

```
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
```

**Alterando tabelas**

```
alter table Pessoa add teste varchar (100);

alter table aluno1 alter column nome varchar(50) null;

alter table Cliente drop column cpf;
drop table <nome da tabela>

alter table Cliente ADD constraint ckIdade check (idade between 18 - 19)

alter table venda alter column dataVenda date Contraint dfDataVenda (getDate())

alter table cliente Drop Constraint ckIdade
```

**Data Manipulation Language**

As cláusulas que tratam a inserção, remoção e eli-
minação de registros dentro de tabelas são INSERT, UPDATE e DELETE, respectivamente.

- Inserção em uma tabela 

  - De uma linha:

    ```
    INSERT INTO MinhaTabela (PriKey, Descricao)
    VALUES (1, ‘TPX450’);
    ```

  - Inserindo dados de uma linha especifica;

    ```
    INSERT INTO Producao.UnidadeDeMedida
    VALUES (‘F2’, ‘Pés quadrados’, GETDATE());
    ```

  - Inserção de Múltiplas linhas 

    ```
    INSERT INTO Producao.UnidadeDeMedida
    VALUES (‘F2’, ‘Pés quadrados’, GETDATE()),
    (‘Y2’, ‘Jardas quadradas’, GETDATE());
    ```

    ```
    INSERT INTO MinhaTabela (PriKey, Descricao)
    VALUES (1, ‘F200’), (2, ‘GTX’), (3, ‘CS’);
    ```

  - Outras formas 

    - Com Select e Views

      ```
      INSERT INTO MinhaTabela (PriKey, Descricao)
      SELECT ChaveEstrangeira, Descricao
      FROM MinhaVisao;
      ```

  Podemos querer inserir um número determinado de linhas usando uma seleção, por exemplo 5 linhas na TabelaA com linhas da TabelaB, fazemos isso da seguinte maneira:

  ```
  INSERT TOP (1) INTO TabelaA
  SELECT ColunaX, ColunaY
  FROM TabelaB;
  ```

  - Inserção em Tabelas com Colunas Auto Numeradas

    ```
    INSERT INTO Veiculo (Placa, Marca) VALUES (‘XPT-7654’, ‘Ford’);
    ```

- Remoção de Dados 

  ```
  DELETE tabela_ou_visao
  FROM fontes_tabelas
  WHERE condicao_de_busca;
  ```

  - Deletar todas as linhas, não coloque o where

    ```
    DELETE FROM Vendedor;
    ```

  - Deletando uma linha especifica 

    ```
    DELETE FROM Vendedor
    WHERE registro = 10;
    ```

  - Remoção com Sub Consulta

    ```
    DELETE FROM
    HistoricoDeVendas
    WHERE
    	registroVendedor 
    IN (
    SELECT
    	Registro
    FROM
    	Vendedor
    WHERE
    	Salario > 10000.00
    );
    ```

  - Remoção com TOP

    Podemos usar TOP para remover algumas linhas somente da tabela, por exemplo, para remover 2,5 porcento da tabela de estoque, usamos o comando:

    ```
    DELETE TOP (2.5) PERCENT
    FROM Estoque;
    ```

  - Truncate tabela (Truncate table)

    Diferença entre deletar ser where:

    - Auto numeração reinicia
    - Se houver chaves estrangeiras não será possível

    ```
    TRUNCATE TABLE Cliente;
    ```

- Atualização de dados

  ```
  UPDATE tabela_ou_visao
  SET nome_da_coluna = expressao
  FROM fontes_tabelas
  WHERE Condicao_e_busca;
  ```

  

  A declaração UPDATE altera valores dos dados de uma ou mais linhas de uma tabela. Uma declaração UPDATE referenciando uma tabela_ou_visao pode alterar os dados somente em uma tabela ao mesmo tempo. Possui três cláusulas principais:

   SET – lista de colunas, separados por vírgula, que serão alterados;

   FROM – fornece objetos fonte para a cláusula SET;

   WHERE – Especifica a condição de procura para aplicar as alterações com a cláusula SET.

  - Sem where, todas as linhas serão afetadas

    ```
    UPDATE Vendedor
    SET Salario = Salario * 1.1;
    ```

  - Com where

    ```
    UPDATE Vendedor
    SET Salario = Salario * 1.1
    WHERE Salario < 10000.00;
    ```

  - Atualização com Sub Consulta

    ```
    UPDATE
    Vendedor
    WHERE
    	Registro IN (
    	SELECT
    		Registro
    	FROM
    		Vendedor
    	WHERE
    		Salario < 10000.00
    );
    ```

    

**Data Query Language** 

Comando SELECT é o principal.

O SELECT é uma declaração SQL que retorna um conjunto de resultados de linhas de uma ou
mais tabelas. Ele recupera zero ou mais linhas de uma ou mais tabelas-base, tabelas temporárias, funções ou visões em um banco de dados. 

Também retorna valores únicos de configurações do sistema de banco de dados ou de variáveis de usuários ou do sistema.

- Cláusulas do SELECT e ordem de Execução:

  - SELECT: Define quais as colunas que serão retornadas;
  -  FROM: Define a(s) tabela(s) envolvidas na consulta;
  -  WHERE: Filtra as linhas requeridas;
  - GROUP BY: Agrupa a lista requerida (utiliza colunas);
  - HAVING: Filtra as linhas requeridas, pelo agrupamento;
  - ORDER BY: Ordena o retorno da lista.

- Exemplo simples

  ```
  SELECT Nome, Sobrenome
  FROM Cliente;
  ```

  ```
  SELECT * FROM exemploSQL
  ```

- Usando operadores Matemáticos

```
SELECT preco, qtd, (preco * qtd)
FROM DetalhesDoPedido;
```

- Apelidos em tabelas

  ```
  SELECT idPedido, preco, qtd AS Quantidade
  FROM DetalhesDoPedido;
  ```

  ```
  SELECT idPedido, preco, Quantidade = qtd
  FROM DetalhesDoPedido;
  ```

  ```
  SELECT idPedido, preco ValorProduto
  FROM DetalhesDoPedido;
  ```

  ```
  SELECT SO.idPedido, SO.dataPedido
  FROM Pedido AS SO;
  ```

- Evitando linhas repetidas:

```
SELECT DISTINCT pais
FROM Cliente;
```

- Devolvendo somente algumas linhas:

  ```
  /* Devolve 10 linhas da tabela exemploSQL */
  SELECT top (10) * FROM exemploSQL;
  ```

  ```
  /* Devolve 10% das linhas da tabela exemploSQL */
  SELECT top 10 percent * FROM exemploSQL;
  ```

- Selecionando as linhas escolhidas:

  ```
  SELECT PrimeiroNome, NomeMeio, UltimoNome
  FROM Pessoa
  WHERE DataNascimento >= ‘20040101’
  ```

  ```
  SELECT IdEntidadeNegocio AS ‘Número Identificação Empegado’,
  DataContratacao,
  HorasDeFerias,
  HorasDoente
  FROM RecursosHumanos.Empregado
  WHERE IdEntidadeNegocio <= 1000
  ```

  ```
  SELECT
  PrimeiroNome,
  SobreNome,
  Telefone
  FROM
  Pessoa.Pessoa
  WHERE
  PrimeiroNome = ‘Jhon’
  ```

- Com operadores lógicos

  ```
  /* Retorna somente registros onde o primeiro nome for ‘John’ E o sobrenome for
  ‘Smith’ */
  WHERE PrimeiroNome = ‘John’ AND UltimoNome = ‘Smith’
  
  /* Retorna todos as linhas onde o primeiro nome for ‘John’ OU todos onde o so-
  brenome for ‘Smith’ */
  
  WHERE PrimeiroNome = ‘John’ OR UltimoNome = ‘Smith’
  ```

- Outros

  

```
SELECT
DataPedido,
NumeroConta,
SubTotal,
Impostos
FROM
Pedidos
WHERE
IdProduto IN (750, 753, 765, 770)
```

- Usando LIKE

  - LIKE ‘Carol%’ é verdadeira para cadeias como Carolina, Caroline e Carola;
  - LIKE ‘Carol_’ é verdadeira
    para cadeias como Carola, mas não Carolina nem Caroline; (Representa somente um caractere)

  - LIKE ‘Carol[ao]’ é verdadeira para as cadeias Carola e Carolo, somente.
  - LIKE ‘Carol[a-e]’ é verdadeira para as cadeias Carola, Carolb, Carolc, Carold e Carole somente.

  - LIKE ‘Carol[^o]’
    é verdadeira para todas as cadeias que tenham Carol no início e mais um caractere exceto ‘o’, ou seja, é falso
    para Carolo e verdadeiro para Carola, Carolb, etc.

[^o]: 

- Usando NULL (Banco de dados não pode comparar um dado null)

  ```
  SELECT IdConsumidor, Cidade, Estado, Pais
  FROM Vendas.Consumidor
  WHERE Estado IS NOT NULL;
  ```

- Ordenação dos resultados da consulta:

  

```
SELECT IdConsumidor, Cidade, Estado, Pais
FROM Vendas.Consumidor
WHERE Estado IS NOT NULL
ORDER BY Estado; -- Poderíamos adicionar ASC ao final
```

```
SELECT IdConsumidor, Cidade, Estado, Pais
FROM Vendas.Consumidor
WHERE Estado IS NOT NULL
ORDER BY Estado DESC;
```

