-- Criar o schema
CREATE USER AULAS IDENTIFIED BY sua_senha;
GRANT CONNECT, RESOURCE TO AULAS;

-- Criar tabela de disciplinas
CREATE TABLE AULAS.disciplinas (
    id_disciplina NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome_disciplina VARCHAR2(100),
    carga_horaria NUMBER,
    area VARCHAR2(100)
);

-- Criar tabela de alunos
CREATE TABLE AULAS.alunos (
    id_aluno NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(100),
    cpf VARCHAR2(11),
    dt_nascimento DATE,
    rua VARCHAR2(100),
    bairro VARCHAR2(100),
    cep VARCHAR2(10),
    cidade VARCHAR2(100),
    estado VARCHAR2(2),
    telefone VARCHAR2(15)
);

-- Selecionar todos os alunos
SELECT * FROM AULAS.alunos;

-- Selecionar cidade e nome de todos os alunos
SELECT cidade, nome FROM AULAS.alunos;

-- Selecionar alunos que residem na cidade de Maringá
SELECT * FROM AULAS.alunos 
WHERE cidade = 'Maringá';

-- Calcular a média das idades dos alunos (exemplo de coluna de idade)
SELECT AVG(TRUNC(MONTHS_BETWEEN(SYSDATE, dt_nascimento) / 12)) AS media_idade FROM AULAS.alunos;

-- Contar total de alunos
SELECT COUNT(*) FROM AULAS.alunos;

-- Alterar o tamanho da coluna telefone na tabela de alunos
ALTER TABLE AULAS.alunos MODIFY (telefone VARCHAR2(20));

-- Inserir um novo aluno na tabela de alunos
INSERT INTO AULAS.alunos (nome, cpf, dt_nascimento, rua, bairro, cep, cidade, estado, telefone) 
VALUES ('Rafaela', '11122233344', TO_DATE('2002-02-02', 'YYYY-MM-DD'), 'Benigna', 'Jardim', '12345-678', 'Colo', 'PR', '23');

-- Atualizar o telefone de um aluno específico
UPDATE AULAS.alunos SET telefone = '88888-1111' WHERE id_aluno = 1;

-- Deletar um aluno específico
DELETE FROM AULAS.alunos WHERE id_aluno = 5;

-- Adicionar uma nova coluna chamada "teste" à tabela "alunos"
ALTER TABLE AULAS.alunos ADD (teste VARCHAR2(100));

-- Remover a coluna "teste" da tabela "alunos"
ALTER TABLE AULAS.alunos DROP COLUMN teste;

-- Modificar o tamanho da coluna "teste" para 200 caracteres (exemplo, para a próxima inserção)
ALTER TABLE AULAS.alunos MODIFY (teste VARCHAR2(200));

-- Renomear a coluna "id_aluno" para "id" na tabela "alunos"
ALTER TABLE AULAS.alunos RENAME COLUMN id_aluno TO id;

---------------------------------------------------------------------------------------------------------------------------------------------

-- Exemplos de JOIN

CREATE TABLE AULAS.disciplinas (
    id_disciplina NUMBER PRIMARY KEY,
    nome_disciplina VARCHAR2(100),
    carga_horaria NUMBER,
    area VARCHAR2(100)
);

CREATE TABLE AULAS.notas (
    id_nota NUMBER PRIMARY KEY,
    id_aluno NUMBER,
    id_disciplina NUMBER,
    teste1 NUMBER(5,2),
    teste2 NUMBER(5,2),
    teste3 NUMBER(5,2),
    teste4 NUMBER(5,2),
    FOREIGN KEY (id_aluno) REFERENCES AULAS.alunos(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES AULAS.disciplinas(id_disciplina)
);

CREATE TABLE AULAS.alunos (
    id_aluno NUMBER PRIMARY KEY,
    id_sala NUMBER,
    nome VARCHAR2(100),
    data_nascimento DATE,
    endereco VARCHAR2(255),
    telefone VARCHAR2(20),
    FOREIGN KEY (id_sala) REFERENCES AULAS.salas(id_sala)
);

-- Exemplos de JOIN

-- 1. INNER JOIN
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
    AULAS.notas n ON a.id_aluno = n.id_aluno
INNER JOIN 
    AULAS.disciplinas d ON n.id_disciplina = d.id_disciplina;

-- 2. LEFT JOIN
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
    AULAS.notas n ON a.id_aluno = n.id_aluno
LEFT JOIN 
    AULAS.disciplinas d ON n.id_disciplina = d.id_disciplina;

-- 3. RIGHT JOIN
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
    AULAS.alunos a ON n.id_aluno = a.id_aluno;

-- 4. FULL OUTER JOIN
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
    AULAS.notas n ON a.id_aluno = n.id_aluno
LEFT JOIN 
    AULAS.disciplinas d ON n.id_disciplina = d.id_disciplina
UNION
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
    AULAS.alunos a ON n.id_aluno = a.id_aluno;

-- Resumo dos JOINs
-- INNER JOIN: Retorna registros com correspondência em ambas as tabelas.
-- LEFT JOIN: Retorna todos os registros da tabela à esquerda e registros correspondentes da tabela à direita; se não houver correspondência, retorna NULL.
-- RIGHT JOIN: Retorna todos os registros da tabela à direita e registros correspondentes da tabela à esquerda; se não houver correspondência, retorna NULL.
-- FULL OUTER JOIN: Retorna todos os registros quando há uma correspondência em uma das tabelas.
