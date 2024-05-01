-- === Criação das Tabelas === --


-- == Tabela País == --

CREATE TABLE tb_pais(
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[nome_pais] [varchar](50) NOT NULL)

-- == Tabela Campeonato == --

CREATE TABLE tb_campeonato(
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_pais] [int] NOT NULL,
	[nome_campeonato] [varchar](50) NOT NULL,
	[divisao] [varchar](50) NOT NULL,
	CONSTRAINT [FK_tb_campeonato_tb_pais] FOREIGN KEY ([id_pais]) REFERENCES [tb_pais] ([id]))

-- == Tabela Time == --

CREATE TABLE tb_time(
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_pais] [int] NOT NULL,
	[id_campeonato] [int],
	[nome_time] [varchar] (50) NOT NULL,
	CONSTRAINT [FK_tb_time_tb_pais] FOREIGN KEY ([id_pais]) REFERENCES [tb_pais] ([id]),
	CONSTRAINT [FK_tb_time_tb_campeonato] FOREIGN KEY ([id_campeonato]) REFERENCES [tb_campeonato] ([id]))

-- == Tabela Jogadores == --

CREATE TABLE tb_jogadores(
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_time] [int],
	[nome_jogador] [varchar] (50) NOT NULL,
	[idade] [int] NOT NULL,
	[posicao] [varchar] (50) NOT NULL,
	[qtd_partidas] [int],
	CONSTRAINT [FK_tb_jogadores_tb_time] FOREIGN KEY ([id_time]) REFERENCES [tb_time] ([id]))

-- == Tabela Estádio == --

CREATE TABLE tb_estadio(
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_time] [int] NOT NULL,
	[nome_estadio] [varchar] (50) NOT NULL,
	[qtd_pessoa] [int] NOT NULL,
	CONSTRAINT [FK_tb_estadio_tb_time] FOREIGN KEY ([id_time]) REFERENCES [tb_time] ([id]))

-- == Tabela Transmissão == --

CREATE TABLE tb_transmissao(
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_campeonato] [int] NOT NULL,
	[nome_canal] [varchar] (50) NOT NULL,
	[nome_narrador] [varchar] (50) NOT NULL,
	CONSTRAINT [FK_tb_transmissao_tb_campeonato] FOREIGN KEY ([id_campeonato]) REFERENCES [tb_campeonato] ([id]))

-- == Tabela Comissão == --

CREATE TABLE tb_comissao(
	[id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[id_time] [int] NOT NULL,
	[nome_tecnico] [varchar] (50) NOT NULL,
	[nome_diretor] [varchar] (50) NOT NULL,
	CONSTRAINT [FK_tb_comissao_tb_time] FOREIGN KEY ([id_time]) REFERENCES [tb_time] ([id]))

-- == Tabela Partida == --

CREATE TABLE tb_partida(
    [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [id_campeonato] [int] NOT NULL,
	[id_estadio] [int] NOT NULL,
    [datas] [datetime] NOT NULL,
    [id_time_casa] [int] NOT NULL,
    [id_time_fora] [int] NOT NULL,
    [gols_time_casa] [int] NOT NULL,
    [gols_time_fora] [int] NOT NULL,

    CONSTRAINT FK_partida_campeonato FOREIGN KEY (id_campeonato) REFERENCES tb_campeonato(id),
	CONSTRAINT FK_partida_estadio FOREIGN KEY (id_estadio) REFERENCES tb_estadio(id),
    CONSTRAINT FK_partida_time_casa FOREIGN KEY (id_time_casa) REFERENCES tb_time(id),
    CONSTRAINT FK_partida_time_fora FOREIGN KEY (id_time_fora) REFERENCES tb_time(id))


-- == Tabela Cartão == --

CREATE TABLE tb_cartao (
    [id] [int] IDENTITY(1,1) NOT NULL primary key,
    [id_partida] [int] NOT NULL,
	[id_time] [int] NOT NULL,
    [id_jogador] [int] NOT NULL,
    [tipo] [varchar](20) NOT NULL,

    CONSTRAINT [FK_cartao_partida] FOREIGN KEY ([id_partida]) REFERENCES [tb_partida] ([id]),
	CONSTRAINT [FK_cartao_time] FOREIGN KEY ([id_time]) REFERENCES [tb_time] ([id]),
    CONSTRAINT [FK_cartao_jogador] FOREIGN KEY ([id_jogador]) REFERENCES [tb_jogadores] ([id]))

-- == Tabela Patrocinador == --

CREATE TABLE tb_patrocinador(
	[id] [int] IDENTITY(1,1) NOT NULL primary key,
	[nome] [varchar](50) NOT NULL,
	[descricao] [varchar](100) NOT NULL)

-- == Tabela Patrocinio == --

CREATE TABLE tb_patrocinio(
	[id] [int] IDENTITY(1,1) NOT NULL primary key,
	[id_time] [int] NOT NULL,
	[id_patrocinador] [int] NOT NULL,
	[valor] [decimal](18, 2) NOT NULL,
	CONSTRAINT FK_patrocinio_time FOREIGN KEY (id_time) REFERENCES tb_time(id),
	CONSTRAINT FK_patrocinio_patrocinador FOREIGN KEY (id_patrocinador) REFERENCES tb_patrocinador(id))

-- == Tabela de gols == --

CREATE TABLE tb_gols(
    [id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [id_partida] [int] NOT NULL,
    [id_time] [int] NOT NULL,
    [id_jogador] [int] NOT NULL,
    [minuto] [int] NOT NULL,
    CONSTRAINT [FK_gols_partida] FOREIGN KEY ([id_partida]) REFERENCES [tb_partida] ([id]),
    CONSTRAINT [FK_gols_time] FOREIGN KEY ([id_time]) REFERENCES [tb_time] ([id]),
    CONSTRAINT [FK_gols_jogador] FOREIGN KEY ([id_jogador]) REFERENCES [tb_jogadores] ([id])
);


-----------------------------------------------


-- === Inserindo Valores nas Tabelas === --


-- == Inserindo Valores em País == --

insert into tb_pais (nome_pais)
values 
('Alemanha'),
('Itália'),
('Espanha'),
('Brasil')


-- == Iserindo Valores em Campeonato == --

insert into tb_campeonato (id_pais, nome_campeonato, divisao)
values 
(1, 'Bundesliga Repescagem', '1ª Divisão'),
(2, 'Campeonato Italiano', '1ª Divisão'),
(3, 'La Liga', '1ª Divisão'),
(4, 'Campeonato Brasileiro', 'Série A')


-- == Inserindo Valores em Time == --

insert into tb_time (id_pais, id_campeonato, nome_time)
values 
(1, 1, 'Borussia Dortmund'),
(2, 2, 'Juventus'),
(3, 3, 'Real Madrid'),
(4, 4, 'Flamengo'),
(4, 4, 'Palmeiras'),
(4, 4, 'Vasco')

insert into tb_time (id_pais, nome_time)
values 
(4, 'Cruzeiro'),
(4, 'Fluminense'),
(4, 'Corinthians')

-- == Inserindo Valores em Jogadores == --


-- = Borussia = --

insert into tb_jogadores (id_time, nome_jogador, idade, posicao)
values 
(1, 'Gregor Kobel', 24, 'Goleiro'),
(1, 'Niklas Süle', 27, 'Zagueiro'),
(1, 'Niko', 22, 'Zagueiro'),
(1, 'Mats', 33, 'Zagueiro'),
(1, 'Raphaël', 28, 'Lateral.E'),
(1, 'Marius Wolf', 27, 'Lateral.D'),
(1, 'Emre Can', 28, 'Volante'),
(1, 'Salih', 24, 'Volante'),
(1, 'Jude', 19, 'Meia.C'),
(1, 'Anthony', 34, 'Centro.A'),
(1, 'Karim', 20, 'Centro.A')


-- = Juventus = --

insert into tb_jogadores (id_time, nome_jogador, idade, posicao)
values 
(2, 'Mattia', 24, 'Goleiro'),
(2, 'Bremer', 27, 'Zagueiro'),
(2, 'Frederico', 22, 'Zagueiro'),
(2, 'Daniele', 33, 'Zagueiro'),
(2, 'Alex Sandro', 28, 'Lateral.E'),
(2, 'Danilo', 27, 'Lateral.D'),
(2, 'Leandro', 28, 'Volante'),
(2, 'Manuel', 24, 'Volante'),
(2, 'Paul Pogba', 19, 'Meia.C'),
(2, 'Moise', 34, 'Centro.A'),
(2, 'Kaio', 20, 'Centro.A')


-- = Real Madrid = --

insert into tb_jogadores (id_time, nome_jogador, idade, posicao)
values 
(3, 'T.Courtois', 24, 'Goleiro'),
(3, 'Militão', 27, 'Zagueiro'),
(3, 'Alaba', 22, 'Zagueiro'),
(3, 'Fernándes', 33, 'Zagueiro'),
(3, 'Mendy', 28, 'Lateral.E'),
(3, 'Carvajal', 27, 'Lateral.D'),
(3, 'Modric', 28, 'Meia.C'),
(3, 'Vinicius Júnior', 24, 'Ponta.E'),
(3, 'Rodrygo', 19, 'Ponta.D'),
(3, 'Benzema', 34, 'Centro.A'),
(3, 'Díaz', 20, 'Centro.A'),
(3, 'Jean', 23, 'Ponta.D'),
(3, 'Evandro', 25, 'Zagueiro'),
(3, 'Vianez', 21, 'Ponta.E'),
(3, 'Victor', 22, 'Centro.A')


-- = Flamengo = --

INSERT INTO tb_jogadores (id_time, nome_jogador, idade, posicao)
values 
(4, 'Diego Alves', 36, 'Goleiro'),
(4, 'Filipe Luís', 36, 'Zagueiro'),
(4, 'Gustavo Henrique', 28, 'Zagueiro'),
(4, 'Rodrigo Caio', 27, 'Zagueiro'),
(4, 'Isla', 33, 'Lateral-direito'),
(4, 'Gerson', 23, 'Volante'),
(4, 'Diego Ribas', 36, 'Meia'),
(4, 'Everton Ribeiro', 32, 'Meia'),
(4, 'Arrascaeta', 27, 'Meia'),
(4, 'Bruno Henrique', 30, 'Atacante'),
(4, 'Gabriel Barbosa', 24, 'Atacante')


-- = Palmeiras = --

INSERT INTO tb_jogadores (id_time, nome_jogador, idade, posicao)
values 
(5, 'Weverton', 33, 'Goleiro'),
(5, 'Luan', 28, 'Zagueiro'),
(5, 'Gustavo Gómez', 28, 'Zagueiro'),
(5, 'Renan', 19, 'Zagueiro'),
(5, 'Marcos Rocha', 32, 'Lateral-direito'),
(5, 'Felipe Melo', 37, 'Volante'),
(5, 'Zé Rafael', 28, 'Meia'),
(5, 'Gustavo Scarpa', 27, 'Meia'),
(5, 'Raphael Veiga', 26, 'Meia'),
(5, 'Rony', 26, 'Atacante'),
(5, 'Luiz Adriano', 34, 'Atacante')


-- = Vasco = --

INSERT INTO tb_jogadores (id_time, nome_jogador, idade, posicao)
values 
(6, 'Fernando Miguel', 36, 'Goleiro'),
(6, 'Léo Matos', 35, 'Lateral-direito'),
(6, 'Ernando', 33, 'Zagueiro'),
(6, 'Leandro Castan', 35, 'Zagueiro'),
(6, 'Zeca', 27, 'Lateral-esquerdo'),
(6, 'Andrey', 24, 'Volante'),
(6, 'Bruno Gomes', 19, 'Volante'),
(6, 'Marquinhos Gabriel', 31, 'Meia'),
(6, 'Benítez', 27, 'Meia'),
(6, 'Gabriel Pec', 21, 'Atacante'),
(6, 'German Cano', 33, 'Atacante')

-- == Inserindo Valores em Estádio == --

insert into tb_estadio (id_time, nome_estadio, qtd_pessoa)
values
(1, 'Signal Iduna Park', 81365),
(2, 'Allianz Stadium', 41507),
(3, 'Santiago Bernabéu', 81044),
(4, 'Maracanã', 78838),
(5, 'Allianz Parque', 45000),
(6, 'Estádio São Januário', 21880)

-- == Inserindo Valores em Transmissão == --

insert into tb_transmissao (id_campeonato, nome_canal, nome_narrador)
values
(1, 'Band-TV', 'Pedro Martelli'),
(2, 'ESPN', 'Paulo Andrade'),
(3, 'Star +', 'Fernando Nardini'),
(4, 'TV Globo', 'Everaldo Marques')


-- == Inserindo Valores em Comissão == --

insert into tb_comissao (id_time, nome_tecnico, nome_diretor)
values
(1, 'Edin Terzic', 'Hans'),
(2, 'Massimiliano Allegri', 'Marco Storari'),
(3, 'Carlo Ancelotti', 'Benito Floro'),
(4, 'Vítor Pereira', 'Rodolfo Landim'),
(5, 'Abel Ferreira', 'Sociedade Esportiva Palmeiras'),
(6, 'Maurício Barbieri', 'Club de Regatas Vasco da Gama')


-- == Inserindo Valores em Partida == -- -- Não executar

--INSERT INTO tb_partida (id_campeonato, id_estadio, datas, id_time_casa, id_time_fora, gols_time_casa, gols_time_fora)
--values 
--(4, 4, '2023-04-15T21:00:00', 4, 6, 2, 3),
--(4, 5, '2023-04-25T21:00:00', 5, 4, 3, 3),
--(3, 3, '2023-06-18T14:00:00', 3, 1, 0, 0),
--(3, 1, '2023-06-23T16:00:00', 1, 3, 0, 0)


-- == Inserindo Valores em Cartão == --

--INSERT INTO tb_cartao (id_partida, id_time, id_jogador, tipo) -- Não executar
--values 
--(1, 4, 39, 'amarelo'), 
--(1, 4, 42, 'vermelho'),
--(1, 4, 44, 'vermelho'),
--(1, 4, 48, 'amarelo'),
--(2, 5, 51, 'amarelo'),
--(2, 5, 57, 'vermelho')

select * from tb_jogadores
select * from tb_partida
select * from tb_cartao


-- == Inserindo Valores em Patrocinador == --

INSERT INTO tb_patrocinador (nome, descricao)
values 
('Nike', 'Empresa americana de calçados, roupas e acessórios esportivos'),
('Adidas', 'Empresa alemã de equipamentos esportivos'),
('Coca-Cola', 'Empresa americana de bebidas não alcoólicas')


-- == Inserindo Valores em Patrocinio == --

--INSERT INTO tb_patrocinio (id_time, id_patrocinador, valor) -- Não executar
--values 
--(3, 1, 700000.00),
--(4, 2, 90000.00),
--(6, 3, 1000000.00)

select * from tb_patrocinador
select * from tb_time
select * from tb_patrocinio


-- == Inserindo Valores em Gols == --

--INSERT INTO tb_gols (id_partida, id_time, id_jogador, minuto) -- Não executar
--values
--(1, 4, 47, 12),
--(1, 4, 48, 35),
--(1, 6, 69, 50),
--(1, 6, 69, 55),
--(1, 6, 70, 89)

-----------------------------------------------


-- === Subconsultas com Operadores === --


-- == Exists == --

select * from tb_jogadores 
where                       
exists (select * from tb_time 
where id_pais = 3
and tb_time.id = tb_jogadores.id_time
) 

-- Puxa os jogadores da tabela jogadores --
-- se existir um pais e um time com o id 3 --



-- == Not Exists == --

select * from tb_jogadores j 
where not exists (select * from tb_time t where j.id_time = t.id and t.id_campeonato = 3)

-- Sendo o inverso da anterior esse comando --
-- puxa todos os jogadores onde não existe --
-- um id_time e um id_campeonato igual a 3 --



-- == In == --

select * from tb_jogadores
where id_time in (1,2)

-- Puxa todos os jogadores que possuem --
-- o id_time 1 e 2 --



-- == Not In == --

select nome_jogador, posicao, id_time
from tb_jogadores
where id_time not in (1,2)

-- Sendo o inverso do anterior puxa todos --
-- os jogadores que não possuem id_time 1 e 2 --



-- == Count / Group by / Having == --

select count(nome_jogador) as total_jogadores, id_time 
from tb_jogadores
group by id_time
having count(nome_jogador) > 11

select * from tb_jogadores
where id_time = 3

-- Conta quantos nomes tem em cada time e --
-- ordena pelo id do time, mas somente o --
-- time que a quantidade de jogadores contadas --
-- for maior que 11 --


-- == Sum == --

select sum(qtd_pessoa) as capacidade_total
from tb_estadio

-- Mostra a soma da quantidade de pessoas --
-- dos 3 estádios somados --



-- == Order By == --

select nome_estadio, qtd_pessoa from tb_estadio 
order by qtd_pessoa desc

select nome_estadio, qtd_pessoa from tb_estadio 
order by qtd_pessoa asc

-- Mostra o nome do estádio e sua quantidade --
-- de pessoas do maior para o menor e do menor --
-- para o maior --



-- == Max == --

select max(qtd_pessoa) as maior_capacidade
from tb_estadio

-- Mostra o estádio com maior capacidade --



-- == Min == --

select min(qtd_pessoa) as menor_capacidade
from tb_estadio

-- Mostra o estádio com menor capacidade --



-- == Select Between == --

select nome_jogador, idade, posicao, id_time
FROM tb_jogadores
WHERE id BETWEEN 10 AND 18

-- Mostra os jogadores entre o id 10 e 18



-- == Select Top == --

select top 33 percent * from tb_jogadores

-- Mostra 33% da tabela jogadores -- 
-- (o equivalente a 1 time completo) --


-----------------------------------------------


-- === View === --


-- == Criando o View Jogadores == --

Go 
-- O Go isola a instrução CREATE VIEW das 
-- instruções USE e SELECT em torno dela

Create view vi_jogadores as
select id_time, 
nome_jogador,
posicao
from tb_jogadores

Go
-- Cria um View que mostra apenas o id do time,
-- o nome do jogadore e sua posição em campo.


-- == Mostrando o View Criado == --

select * from vi_jogadores

-----------------------------------------------


-- === Índice === --


-- == Criando um Índice em Jogadores == --

create nonclustered index indice_nao_clusterizado
on tb_jogadores (idade)


-- Cria um indice não clusterizado em idade para
-- um retorno mais eficiente durante a pesquisa


select * from tb_jogadores
where idade > 22


--================================================--


-- == Criando um Trigger == --

CREATE TRIGGER atualiza_qtd_partidas
ON tb_partida
AFTER INSERT, UPDATE
AS
BEGIN
  UPDATE tb_jogadores
  SET qtd_partidas = (
    SELECT COUNT(*)
    FROM tb_partida p
    WHERE tb_jogadores.id_time IN (p.id_time_casa, p.id_time_fora)
  )
  FROM tb_jogadores
  INNER JOIN inserted i ON tb_jogadores.id_time = i.id_time_casa OR tb_jogadores.id_time = i.id_time_fora;
END

-- Cria um trigger que atualiza a quantidade de partidas de cada jogador
-- Toda vez que houver um INSERT ou UPDATE na tabela de Partidas 
-- que contenha o seu time.

select id_time, nome_jogador, posicao, qtd_partidas 
from tb_jogadores

INSERT INTO tb_partida (id_campeonato, id_estadio, datas, id_time_casa, id_time_fora, gols_time_casa, gols_time_fora)
values 
(4, 4, '2023-04-15T21:00:00', 4, 6, 2, 3),
(3, 3, '2023-05-15T16:00:00', 3, 4, 5, 0)

select * from tb_partida
-----------------------------------------------

-- == Criando um IIF == --

SELECT id_time, nome_jogador, posicao, qtd_partidas, 
    jogou_partida = IIF(qtd_partidas > 0, 'Sim', 'Não')
FROM tb_jogadores;

-- Verifica se a quantidade de partidas de um jogador
-- é maior que 0 e retorna Sim ou Não.

-----------------------------------------------

-- == Criando um If/Else == --

IF EXISTS (SELECT * FROM tb_patrocinio)
BEGIN
    SELECT tb_time.nome_time, tb_patrocinador.nome
    FROM tb_time
    INNER JOIN tb_patrocinio ON tb_time.id = tb_patrocinio.id_time
    INNER JOIN tb_patrocinador ON tb_patrocinio.id_patrocinador = tb_patrocinador.id
END
ELSE
BEGIN
    SELECT nome_time
    FROM tb_time
END

-- Esse comando IF verifica se existem registros na tb_patrocinio,
-- Se houver ele mostra o nome do time e o seu Patrocinador.
-- Caso não houver ele só mostra o nome dos times.

DELETE * FROM tb_patrocinio

INSERT INTO tb_patrocinio (id_time, id_patrocinador, valor)
values 
(3, 1, 700000.00),
(4, 2, 90000.00),
(6, 3, 1000000.00)

-----------------------------------------------

-- == Criando um While, Break e Continue == --

DECLARE @timeID INT
DECLARE @maxTimeID INT

SET @timeID = 1
SELECT @maxTimeID = MAX(id) FROM tb_time

WHILE (@timeID <= @maxTimeID)
BEGIN
    IF NOT EXISTS(SELECT 1 FROM tb_time WHERE id = @timeID)
    BEGIN
        SET @timeID = @timeID + 1
        CONTINUE
    END
    
    SELECT t.nome_time, c.nome_campeonato
    FROM tb_time t
    INNER JOIN tb_campeonato c ON t.id_campeonato = c.id
    WHERE t.id = @timeID

    SET @timeID = @timeID + 1
    
    IF (@timeID > @maxTimeID)
    BEGIN
        BREAK
    END
END

-- O WHILE é utilizado para iterar pelo ID dos times na tb_time. 
-- A cada iteração, verifica se o ID atual existe na tabela, se existir, 
-- mostra o nome do time e o nome do campeonato usando o INNER JOIN. 
-- Se não, ele avança para a próxima iteração, usando o CONTINUE. 
-- O loop é interrompido quando o ID atual ultrapassa o ID máximo existente 
-- na tabela, usando o BREAK.

-----------------------------------------------

-- == Criando um Case When == --

SELECT id_time, nome_jogador, posicao, qtd_partidas,
CASE 
    WHEN (SELECT COUNT(*) FROM tb_cartao WHERE id_jogador = tb_jogadores.id AND tipo = 'amarelo') >= 2 
        OR (SELECT COUNT(*) FROM tb_cartao WHERE id_jogador = tb_jogadores.id AND tipo = 'vermelho') >= 1 
        THEN 'Suspenso'
    ELSE 'Disponível'
END AS situacao_jogador
FROM tb_jogadores

-- O CASE WHEN verifica o número de cartões amarelos e vermelhos que o 
-- jogador recebeu, se for maior ou igual a 2 cartões amarelos ou 
-- 1 cartão vermelho, a coluna "situacao_jogador" é preenchida 
-- com "Suspenso". Caso contrário, será preenchida com "Disponível".

-- Flamengo
INSERT INTO tb_cartao (id_partida, id_time, id_jogador, tipo) 
values 
(1, 4, 38, 'vermelho'),
(1, 4, 39, 'vermelho'), 
(1, 4, 40, 'vermelho'), 
(1, 4, 41, 'vermelho'), 
(1, 4, 42, 'vermelho'), 
(1, 4, 43, 'vermelho'), 
(1, 4, 44, 'vermelho'),
(1, 4, 45, 'vermelho'),
(1, 4, 46, 'vermelho'),
(1, 4, 47, 'vermelho'),
(1, 4, 48, 'vermelho')

--================================================--


-- == Criando uma Função == --

CREATE FUNCTION dbo.fn_total_gols_jogador(@id_jogador INT)
RETURNS INT
AS
BEGIN
    DECLARE @total_gols INT;
    SELECT @total_gols = COUNT(*)
    FROM tb_gols
    WHERE id_jogador = @id_jogador;

    RETURN @total_gols;
END;

--Recebe o id do jogador e retorna a quantidade de gols 
--marcados por ele, contando a quantidade de registros 
--na tb_gols que possuem o seu id.

SELECT dbo.fn_total_gols_jogador(69) AS total_gols_jogador

INSERT INTO tb_gols (id_partida, id_time, id_jogador, minuto)
values
(1, 4, 47, 12),
(1, 4, 48, 35),
(1, 6, 69, 50),
(1, 6, 69, 55),
(1, 6, 70, 89)

select*from tb_jogadores where id = 69

-----------------------------------------------

-- == Criando uma Procedure == --

CREATE PROCEDURE sp_partidas_do_jogador
    @nome_jogador varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

    -- Encontrar o id do jogador
    DECLARE @id_jogador int;
    SELECT @id_jogador = id
    FROM tb_jogadores
    WHERE nome_jogador = @nome_jogador;

    -- Encontrar o id do time do jogador
    DECLARE @id_time int;
    SELECT @id_time = id_time
    FROM tb_jogadores
    WHERE nome_jogador = @nome_jogador;

    -- Encontrar as partidas em que o jogador participou pelo seu time
    SELECT *
    FROM tb_partida
    WHERE (id_time_casa = @id_time) OR (id_time_fora = @id_time);
END

--Essa procedure retorna todas as partidas em que um determinado 
--jogador participou, usando o nome dele.

-- Ou seja, ela pega o nome do jogador, obtém o id do jogador pelo nome dele,
-- obtém o id do time pelo nome do jogador e retorna todas as partidas
-- em que ele participa.

EXEC sp_partidas_do_jogador 'Gabriel Pec'

SELECT *
FROM tb_jogadores
WHERE id_time IN (3, 4, 6);


-----------------------------------------------

-- == Criando uma Transação Commit/RollBack == --

BEGIN TRY
    BEGIN TRANSACTION

    -- Inserção na tabela tb_time
    INSERT INTO tb_time (id_pais, id_campeonato, nome_time)
    VALUES ('Quatro', 4, 'Teste2')--Grêmio

    DECLARE @id_time_tr int
    SET @id_time_tr = SCOPE_IDENTITY() -- Obtém o ID gerado automaticamente

    -- Inserção na tabela tb_jogadores
    INSERT INTO tb_jogadores (id_time, nome_jogador, idade, posicao)
    VALUES (@id_time_tr, 'Zezinho do Som', 22, 'DJ')

    -- Confirmação da transação
    COMMIT TRANSACTION

    SELECT 'Transação confirmada' AS Status

END TRY
BEGIN CATCH

    -- Cancelamento da transação em caso de erro
    ROLLBACK TRANSACTION

    SELECT 'Transação cancelada' AS Status
END CATCH

--Insere um novo time na tb_time, obtém o ID gerado automaticamente e, 
--insere um novo jogador na tb_jogadores, Se der certo é exibida a 
--mensagem "Transação confirmada", Se não a transação é cancelada 
--e é exibida a mensagem "Transação cancelada".

select * from tb_time
select * from tb_jogadores

-----------------------------------------------

-- == Criando um Cursor == --

DECLARE @timeID INT -- Declara todas as variáveis 
DECLARE @idadeTotal INT
DECLARE @qtdJogadores INT
DECLARE @mediaIdade FLOAT
DECLARE @idade INT 

SET @timeID = 5 -- Alterar para o Id do time desejado
SET @idadeTotal = 0
SET @qtdJogadores = 0

-- Conta os jogadores referentes ao id do time passado
SELECT @qtdJogadores = COUNT(*) FROM tb_jogadores WHERE id_time = @timeID

-- Se a qtd de jogadores for maior que 0 calcula a média
IF @qtdJogadores > 0
BEGIN
    DECLARE jogadores_cursor CURSOR FOR
        SELECT idade FROM tb_jogadores WHERE id_time = @timeID

    OPEN jogadores_cursor
    FETCH NEXT FROM jogadores_cursor INTO @idade

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @idadeTotal = @idadeTotal + @idade

        FETCH NEXT FROM jogadores_cursor INTO @idade
    END

    CLOSE jogadores_cursor
    DEALLOCATE jogadores_cursor

    SET @mediaIdade = @idadeTotal / @qtdJogadores

    SELECT
        (SELECT nome_time FROM tb_time WHERE id = @timeID) AS NomeTime,
        @mediaIdade AS MediaIdade
END
-- Se a qtd de jogadores não for maior de 0, retorna a seguinte mensagem:
ELSE
BEGIN
    PRINT 'Não há jogadores cadastrados para o time especificado.'
END


-- calcula a média de idade dos jogadores de um determinado time
-- e retorna o nome do time junto com a média de idade.
