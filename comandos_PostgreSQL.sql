📌 Conexão e Banco de Dados

-- Conectar ao PostgreSQL (via terminal)
psql -U usuario -d nome_do_banco -h localhost -p 5432

-- Listar bancos de dados disponíveis
\l

-- Criar um banco de dados
CREATE DATABASE nome_do_banco;

-- Apagar um banco de dados
DROP DATABASE nome_do_banco;

-- Conectar a um banco de dados específico
\c nome_do_banco;

-- Listar tabelas do banco conectado
\dt
    
📌 Tabelas

-- Criar uma tabela
CREATE TABLE pessoa (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    idade INT,
    email VARCHAR(150) UNIQUE
);

-- Mostrar estrutura da tabela
\d pessoa

-- Apagar uma tabela
DROP TABLE pessoa;

📌 Manipulação de Dados

-- Inserir dados
INSERT INTO pessoa (nome, idade, email) VALUES ('João', 30, 'joao@email.com');

-- Atualizar dados
UPDATE pessoa SET idade = 31 WHERE nome = 'João';

-- Deletar um registro
DELETE FROM pessoa WHERE nome = 'João';

📌 Consultas (SELECT)

    
-- Selecionar todos os registros
SELECT * FROM pessoa;

-- Selecionar campos específicos
SELECT nome, email FROM pessoa;

-- Filtrar registros
SELECT * FROM pessoa WHERE idade > 25;

-- Ordenar registros (ASC = crescente, DESC = decrescente)
SELECT * FROM pessoa ORDER BY idade DESC;

-- Contar registros
SELECT COUNT(*) FROM pessoa;

📌 Chaves Estrangeiras (Relacionamento)

-- Criar uma tabela com chave estrangeira
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    id_pessoa INT REFERENCES pessoa(id),
    descricao TEXT NOT NULL
);
📌 Usuários e Permissões

-- Criar um usuário
CREATE USER meu_usuario WITH PASSWORD 'minha_senha';

-- Conceder permissão a um usuário
GRANT ALL PRIVILEGES ON DATABASE nome_do_banco TO meu_usuario;
