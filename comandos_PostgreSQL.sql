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

-- Selecionar todos os atributos da tabela, porém 10.
SELECT * FROM minha_tabela LIMIT 10;


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


-----------------------------------------
SELECT
    p.id_cliente AS ID_Cliente,
    p.nome_cliente AS Nome_Cliente,
    p.status AS Status_Cliente,
    c.tipo_comentario AS "Tipo Comentário",
    d.nome_departamento AS "Departamento",
    t.valor_investido AS "Valor Investido",
    t.valor_retornado AS "Valor Retornado",
    CASE WHEN c.tipo_comentario = 'Avaliacao de Serviço' THEN f.nome_departamento ELSE NULL END AS "Departamento Anterior",
    CASE WHEN c.tipo_comentario = 'Avaliacao de Serviço' THEN g.nome_departamento ELSE NULL END AS "Novo Departamento",
    t.data_atividade AS "Data da Atividade"
FROM atividades t
INNER JOIN clientes p ON p.id_cliente = t.id_cliente
INNER JOIN comentarios c ON c.id_comentario = t.id_comentario
INNER JOIN departamentos d ON d.id_departamento = p.id_departamento_cliente
LEFT JOIN departamentos f ON f.id_departamento = CASE WHEN c.tipo_comentario = 'Avaliacao de Serviço' AND t.valor_investido ~ '^[0-9]+$' THEN t.valor_investido::INTEGER ELSE NULL END
LEFT JOIN departamentos g ON g.id_departamento = CASE WHEN c.tipo_comentario = 'Avaliacao de Serviço' AND t.valor_retornado ~ '^[0-9]+$' THEN t.valor_retornado::INTEGER ELSE NULL END
WHERE t.data_atividade BETWEEN '2023-01-01 00:00:00' AND '2023-12-30 23:59:59'
ORDER BY d.nome_departamento, p.nome_cliente, c.tipo_comentario;

