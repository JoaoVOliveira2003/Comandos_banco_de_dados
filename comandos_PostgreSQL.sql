-- Criar o schema
CREATE SCHEMA AULAS;

-- Criar tabela de disciplinas
CREATE TABLE AULAS.disciplinas (
    id_disciplina SERIAL PRIMARY KEY,
    nome_disciplina VARCHAR(100),
    carga_horaria INT,
    area VARCHAR(100)
);

-- Criar tabela de alunos
CREATE TABLE AULAS.alunos (
    id_aluno SERIAL PRIMARY KEY,
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
SELECT AVG(EXTRACT(YEAR FROM AGE(dt_nascimento))) AS media_idade FROM AULAS.alunos;

-- Contar total de alunos
SELECT COUNT(*) FROM AULAS.alunos;

-- Alterar o tamanho da coluna telefone na tabela de alunos
ALTER TABLE AULAS.alunos ALTER COLUMN telefone TYPE VARCHAR(20);

-- Inserir um novo aluno na tabela de alunos
INSERT INTO AULAS.alunos (nome, cpf, dt_nascimento, rua, bairro, cep, cidade, estado, telefone) 
VALUES ('Rafaela', '11122233344', '2002-02-02', 'Benigna', 'Jardim', '12345-678', 'Colo', 'PR', '23');

-- Atualizar o telefone de um aluno específico
UPDATE AULAS.alunos SET telefone = '88888-1111' WHERE id_aluno = 1;

-- Deletar um aluno específico
DELETE FROM AULAS.alunos WHERE id_aluno = 5;

-- Adicionar uma nova coluna chamada "teste" à tabela "alunos"
ALTER TABLE AULAS.alunos ADD COLUMN teste VARCHAR(100);

-- Remover a coluna "teste" da tabela "alunos"
ALTER TABLE AULAS.alunos DROP COLUMN teste;

-- Modificar o tamanho da coluna "teste" para 200 caracteres (exemplo, para a próxima inserção)
ALTER TABLE AULAS.alunos ALTER COLUMN teste TYPE VARCHAR(200);

-- Renomear a coluna "id_aluno" para "id" na tabela "alunos"
ALTER TABLE AULAS.alunos RENAME COLUMN id_aluno TO id;

---------------------------------------------------------------------------------------------------------------------------------------------

-- Criar tabela de notas
CREATE TABLE AULAS.notas (
    id_nota SERIAL PRIMARY KEY,
    id_aluno INT REFERENCES AULAS.alunos(id),
    id_disciplina INT REFERENCES AULAS.disciplinas(id_disciplina),
    teste1 DECIMAL(5,2),
    teste2 DECIMAL(5,2),
    teste3 DECIMAL(5,2),
    teste4 DECIMAL(5,2)
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
    AULAS.alunos a
INNER JOIN 
    AULAS.notas n ON a.id = n.id_aluno
INNER JOIN 
    AULAS.disciplinas d ON n.id_disciplina = d.id_disciplina;

-- 2. LEFT JOIN
-- O LEFT JOIN retorna todas as linhas da tabela à esquerda (neste caso, alunos) e as linhas correspondentes da tabela à direita (notas e disciplinas). 
-- Se não houver correspondência, os resultados da tabela à direita serão NULL.
SELECT 
    a.nome AS aluno,
    d.nome_disciplina,
    n.teste1,
    n.teste2,
    n.teste3,
    n.teste4
FROM 
    AULAS.alunos a
LEFT JOIN 
    AULAS.notas n ON a.id = n.id_aluno
LEFT JOIN 
    AULAS.disciplinas d ON n.id_disciplina = d.id_disciplina;

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
    AULAS.notas n
RIGHT JOIN 
    AULAS.disciplinas d ON n.id_disciplina = d.id_disciplina
RIGHT JOIN 
    AULAS.alunos a ON n.id_aluno = a.id;

-- 4. FULL OUTER JOIN
-- Um FULL OUTER JOIN retorna todas as linhas quando há uma correspondência em uma das tabelas. 
-- No entanto, o PostgreSQL suporta FULL OUTER JOIN diretamente.
SELECT 
    a.nome AS aluno,
    d.nome_disciplina,
    n.teste1,
    n.teste2,
    n.teste3,
    n.teste4
FROM 
    AULAS.alunos a
FULL OUTER JOIN 
    AULAS.notas n ON a.id = n.id_aluno
FULL OUTER JOIN 
    AULAS.disciplinas d ON n.id_disciplina = d.id_disciplina;

-- Resumo dos JOINs
-- INNER JOIN: Retorna registros com correspondência em ambas as tabelas.
-- LEFT JOIN: Retorna todos os registros da tabela à esquerda e registros correspondentes da tabela à direita; se não houver correspondência, retorna NULL.
-- RIGHT JOIN: Retorna todos os registros da tabela à direita e registros correspondentes da tabela à esquerda; se não houver correspondência, retorna NULL.
-- FULL OUTER JOIN: Retorna todos os registros quando há uma correspondência em uma das tabelas.
