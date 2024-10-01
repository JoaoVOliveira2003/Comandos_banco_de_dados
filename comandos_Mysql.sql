-- Criar o schema
CREATE SCHEMA AULAS;

-- Criar tabela de disciplinas
CREATE TABLE AULAS.disciplinas (
    id_disciplina INT PRIMARY KEY AUTO_INCREMENT,
    nome_disciplina VARCHAR(100),
    carga_horaria INT,
    area VARCHAR(100)
);

-- Criar tabela de alunos
CREATE TABLE AULAS.alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cpf VARCHAR(11),
    dt_nascimento DATE,
    rua VARCHAR(100),
    bairro VARCHAR(100),
    cep VARCHAR(10),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    telefone VARCHAR(15)
);

-- Selecionar todos os alunos
SELECT * FROM AULAS.alunos;

-- Selecionar cidade e nome de todos os alunos
SELECT cidade, nome FROM AULAS.alunos;

-- Selecionar alunos que residem na cidade de Maringá
SELECT * FROM AULAS.alunos 
WHERE cidade = 'Maringá';

-- Calcular a média das idades dos alunos (exemplo de coluna de idade)
SELECT AVG(TIMESTAMPDIFF(YEAR, dt_nascimento, CURDATE())) AS media_idade FROM AULAS.alunos;

-- Contar total de alunos
SELECT COUNT(*) FROM AULAS.alunos;

-- Alterar o tamanho da coluna telefone na tabela de alunos
ALTER TABLE AULAS.alunos MODIFY COLUMN telefone VARCHAR(20);

-- Inserir um novo aluno na tabela de alunos
INSERT INTO AULAS.alunos (nome, cpf, dt_nascimento, rua, bairro, cep, cidade, estado, telefone) 
VALUES ('Rafaela', '11122233344', '2002-02-02', 'Benigna', 'Jardim', '12345-678', 'Colo', 'PR', '23');

-- Atualizar o telefone de um aluno específico
UPDATE AULAS.alunos SET telefone = '88888-1111' WHERE id_aluno = 1;

-- Deletar um aluno específico
DELETE FROM AULAS.alunos WHERE id_aluno = 5;

-- Adicionar uma nova coluna chamada "teste" à tabela "alunos"
ALTER TABLE AULAS.alunos ADD teste VARCHAR(100);

-- Remover a coluna "teste" da tabela "alunos"
ALTER TABLE AULAS.alunos DROP COLUMN teste;

-- Modificar o tamanho da coluna "teste" para 200 caracteres (exemplo, para a próxima inserção)
ALTER TABLE AULAS.alunos MODIFY COLUMN teste VARCHAR(200);

-- Renomear a coluna "id_aluno" para "id" na tabela "alunos"
ALTER TABLE AULAS.alunos CHANGE COLUMN id_aluno id INT;

---------------------------------------------------------------------------------------------------------------------------------------------
--exemplos de JOIN

CREATE TABLE escola.disciplinas (
    id_disciplina INT PRIMARY KEY,
    nome_disciplina VARCHAR(100),
    carga_horaria INT,
    area VARCHAR(100)
);

CREATE TABLE escola.notas (
    id_nota INT PRIMARY KEY,
    id_aluno INT,
    id_disciplina INT,
    teste1 DECIMAL(5,2),
    teste2 DECIMAL(5,2),
    teste3 DECIMAL(5,2),
    teste4 DECIMAL(5,2),
    FOREIGN KEY (id_aluno) REFERENCES escola.alunos(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES escola.disciplinas(id_disciplina)
);

CREATE TABLE escola.alunos (
    id_aluno INT PRIMARY KEY,
    id_sala INT,
    nome VARCHAR(100),
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    FOREIGN KEY (id_sala) REFERENCES escola.salas(id_sala),
);


-- Exemplos de JOIN


-- 1. INNER JOIN
-- O INNER JOIN retorna apenas as linhas que têm correspondência em ambas as tabelas. Neste caso, estamos buscando alunos que têm notas em disciplinas.

SELECT 
    a.nome AS aluno,
    d.nome_disciplina,
    n.teste1,
    n.teste2,
    n.teste3,
    n.teste4
FROM 
    escola.alunos a
INNER JOIN 
    escola.notas n ON a.id_aluno = n.id_aluno
INNER JOIN 
    escola.disciplinas d ON n.id_disciplina = d.id_disciplina;


-- 2. LEFT JOIN
-- O LEFT JOIN retorna todas as linhas da tabela à esquerda (neste caso, alunos) e as linhas correspondentes da tabela à direita (notas e disciplinas). 
--Se não houver correspondência, os resultados da tabela à direita serão NULL.

SELECT 
    a.nome AS aluno,
    d.nome_disciplina,
    n.teste1,
    n.teste2,
    n.teste3,
    n.teste4
FROM 
    escola.alunos a
LEFT JOIN 
    escola.notas n ON a.id_aluno = n.id_aluno
LEFT JOIN 
    escola.disciplinas d ON n.id_disciplina = d.id_disciplina;


-- 3. RIGHT JOIN
-- O RIGHT JOIN retorna todas as linhas da tabela à direita (notas e disciplinas) e as linhas correspondentes da tabela à esquerda (alunos).
-- Se não houver correspondência, os resultados da tabela à esquerda serão NULL.

SELECT 
    a.nome AS aluno,
    d.nome_disciplina,
    n.teste1,
    n.teste2,
    n.teste3,
    n.teste4
FROM 
    escola.notas n
RIGHT JOIN 
    escola.disciplinas d ON n.id_disciplina = d.id_disciplina
RIGHT JOIN 
    escola.alunos a ON n.id_aluno = a.id_aluno;

-- 4. FULL OUTER JOIN
-- Um FULL OUTER JOIN retorna todas as linhas quando há uma correspondência em uma das tabelas. No entanto, 
-- o MySQL não suporta FULL OUTER JOIN diretamente, mas você pode obter um resultado semelhante usando UNION com LEFT JOIN e RIGHT JOIN.

SELECT 
    a.nome AS aluno,
    d.nome_disciplina,
    n.teste1,
    n.teste2,
    n.teste3,
    n.teste4
FROM 
    escola.alunos a
LEFT JOIN 
    escola.notas n ON a.id_aluno = n.id_aluno
LEFT JOIN 
    escola.disciplinas d ON n.id_disciplina = d.id_disciplina
UNION
SELECT 
    a.nome AS aluno,
    d.nome_disciplina,
    n.teste1,
    n.teste2,
    n.teste3,
    n.teste4
FROM 
    escola.notas n
RIGHT JOIN 
    escola.disciplinas d ON n.id_disciplina = d.id_disciplina
RIGHT JOIN 
    escola.alunos a ON n.id_aluno = a.id_aluno;

-- Resumo dos JOINs
INNER JOIN: Retorna registros com correspondência em ambas as tabelas.
LEFT JOIN: Retorna todos os registros da tabela à esquerda e registros correspondentes da tabela à direita; se não houver correspondência, retorna NULL.
RIGHT JOIN: Retorna todos os registros da tabela à direita e registros correspondentes da tabela à esquerda; se não houver correspondência, retorna NULL.
FULL OUTER JOIN: Retorna todos os registros quando há uma correspondência em uma das tabelas (não suportado diretamente no MySQL, mas pode ser simulado).

---------------------------------------------------------------------
--Conseguir informaçoes de uma tabela:
sp_help nome_Tabela

--Pega um dado,se acabar com final '.com' vai para uma coluna 'contato_correto' se não for ira 'contato_errado'
CASE
    WHEN contato IS NULL THEN NULL
    WHEN contato LIKE '%.com' THEN contato
    ELSE NULL 
END AS contato_correto,
CASE 
    WHEN contato IS NULL THEN NULL
    WHEN contato LIKE '%.com' THEN NULL
    ELSE contato
END AS contato_errado,
