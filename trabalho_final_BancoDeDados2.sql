-- Tabela de disciplinas
CREATE TABLE escola.disciplinas (
    id_disciplina INT PRIMARY KEY,
    nome_disciplina VARCHAR(100),
    carga_horaria INT,
    area VARCHAR(100)
);

/*
Nome da Tabela:
    Disciplinas.
   A tabela central desse sistema é disciplina, livros são de uma disciplina,professores 
   ministram determinada matéria e a nota do aluno vem a partir de uma matéria,
   assim podendo ser chamada de “chave mestra para todo o sistema”,
   pois é possível a ver como chave estrangeira em outras tabelas do sistema.	

Colunas:
    id_disciplina INT PRIMARY KEY,  - a chave primaria de Disciplinas 
    nome_disciplina VARCHAR(100),   - o nome da disciplina
    carga_horaria INT,              - a carga horária
    area VARCHAR(100)               - a área do conhecimento qual essa matéria se encontra 

Relacionamentos:
Ela é chave estrangeira em professores,livros e notas.
*/

-- Tabela de salas
CREATE TABLE escola.salas (
    id_sala INT PRIMARY KEY,
    nome_sala VARCHAR(100),
    curso VARCHAR(100),          
    numero_de_alunos INT  
);

/*
Nome da Tabela:
    A tabela salas não se referência a uma sala física,
    mas sim a um conjunto de alunos e como eles são classificados,
    portanto ela não deseja falar “sala do bosque”, 
    mas sim a sala “Info2019 do curso de informática”.

Colunas:
    id_sala INT PRIMARY KEY, - o id_sala chave estrangeira em alunos .
    nome_sala VARCHAR(100),  - o nome da sala.
    curso VARCHAR(100),      - o curso que esta turma(sala) está.  	
    numero_de_alunos INT     - o número de alunos dessa sala,inserido apenas ao criar a tabela.

Relacionamentos:
   Não possui chaves estrangeiras em si, mas é chave estrangeira em outra tabela (alunos).
*/

-- Tabela de notas
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

/*
Nome da Tabela:
    A tabela  notas, não representa a nota final de um aluno,
    mas sim possui 4 testes que quando se faz a média das quatro faz a nota final do aluno, 
    além destes 4 testes,possui seu id próprio,e chaves estrangeiras id que ele se refere a uma disciplina 
    e um aluno expecificamente.

Colunas:
    id_nota INT PRIMARY KEY, -primary key para identificar qual nota específica é.
    id_aluno INT,		     -chave estrangeira de alunos, identifica qual aluno.
    id_disciplina INT,       -chave estrangeira de alunos, identifica qual disciplina.
    teste1 DECIMAL(5,2),	 -primeiro teste.
    teste2 DECIMAL(5,2),     -segundo teste.
    teste3 DECIMAL(5,2),     -terceiro teste.
    teste4 DECIMAL(5,2),     -quarto teste.

Relacionamentos:
     Ela tem 2 chaves estrangeiras, id_aluno e id disciplina, e não é chave estrangeira em nenhum outro lugar. 
*/

-- Tabela de alunos
CREATE TABLE escola.alunos (
    id_aluno INT PRIMARY KEY,
    id_sala INT,
    nome VARCHAR(100),
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(20),
    FOREIGN KEY (id_sala) REFERENCES escola.salas(id_sala),
);

/*
Nome da Tabela:
    Alunos, não representa um conjunto de alunos, mas sim apenas um aluno específico,
    além de demonstrar o nome do aluno,esta tabela mostra qual aluno ele é,
    tem seu nome, data de nascimento,endereço e de qual sala (turma) ele pertence.

Colunas:
    id_aluno INT PRIMARY KEY,  - id que o identifica
    id_sala INT,		       - id que demonstra de qual sala ele é 
    nome VARCHAR(100),	       - nome do indivíduo.
    data_nascimento DATE,      - data de nascimento do indivíduo.
    endereco VARCHAR(255),     - endereço do indivíduo. 
    telefone VARCHAR(20),      - telefone do indivíduo. 

Relacionamentos:
    Alunos, apenas têm uma chave estrangeira id_sala da qual como dito anteriormente 
    demonstra fala qual sala o aluno pertence.
*/

-- Tabela de livros
CREATE TABLE escola.livros (
    id_livro INT PRIMARY KEY,
    nome VARCHAR(100),
    autor VARCHAR(100),
    id_disciplina INT,
    disponivel BOOLEAN,
    FOREIGN KEY (id_disciplina) REFERENCES escola.disciplinas(id_disciplina)
);

/*
Nome da Tabela:
    O raciocínio para a criação desta tabela foi a necessidade de uma biblioteca,
    porém optou-se em fazer 1 livro por vez em vez de criar várias tabelas para uma só biblioteca.  

Colunas:
    id_livro INT PRIMARY KEY,   - demonstra qual livro específico é.
    nome VARCHAR(100),	        - o nome do livro
    autor VARCHAR(100),         - nome do autor
    id_disciplina INT,          - id que demonstra de qual matéria ele é
    disponivel BOOLEAN,         - e um disponível para demonstrar se esta    
                                 disponível(TRUE) ou indisponível(FALSE).

Relacionamentos:
    Livro não é chave estrangeira em nenhum outro lugar,
    porém possui uma chave estrangeira, id disciplina, que demonstra de qual disciplina o livro pertence.
    Exemplo “ 'Matemática Divertida e Curiosa'”,”1”  sendo 1 o id da disciplina matemática. 
*/

-- Tabela de professores
CREATE TABLE escola.professores (
    id_professor INT PRIMARY KEY,
    nome VARCHAR(100),
    telefone VARCHAR(20),
    id_disciplina INT,
    FOREIGN KEY (id_disciplina) REFERENCES escola.disciplinas(id_disciplina)
);


/*
Nome da Tabela:
    Assim como tem uma tabela para representar os alunos, tem uma tabela para a representação dos professores que lecionam as matérias, um professor no contexto dessa schema de tabelas leciona uma disciplina.

Colunas:
    id_professor INT PRIMARY KEY, - o id que demonstra qual professor expecifico é 
    nome VARCHAR(100),		      - o nome do professor. 
    telefone VARCHAR(20),	 	  - o telefone do professor.
    id_disciplina INT,			  - o id que demonstra qual é a materia que este 
                                    professor faz suas aulas

Relacionamentos:
   Professor não é uma tabela estrangeira em outros lugares do banco,
   porém possui o id_disciplina, do qual demonstra de qual disciplina esse professor leciona. 
*/


----------------------------------------------------------------------------------------------------------------------

-- Inserir disciplinas na tabela escola.disciplinas
INSERT INTO escola.disciplinas (id_disciplina, nome_disciplina, carga_horaria, area) VALUES
(1, 'Matemática', 60, 'Exatas'),
(2, 'História', 45, 'Humanas'),
(3, 'Biologia', 60, 'Ciências'),
(4, 'Química', 45, 'Ciências');

-- Inserir alunos na tabela escola.alunos
INSERT INTO escola.alunos (id_aluno, id_sala, nome, data_nascimento, endereco, telefone) VALUES
(1, 1, 'Ana Silva', '2005-03-12', 'Rua das Flores, 123', '(41) 99999-1234'),
(2, 1, 'Bruno Costa', '2004-07-23', 'Avenida Central, 456', '(41) 98888-5678'),
(3, 2, 'Carlos Almeida', '2005-01-15', 'Rua das Acácias, 789', '(41) 97777-9101'),
(4, 2, 'Diana Pereira', '2004-09-30', 'Rua dos Pinheiros, 101', '(41) 96666-1122'),
(5, 3, 'Eduardo Lima', '2005-06-22', 'Praça da República, 202', '(41) 95555-1313'),
(6, 3, 'Fernanda Rocha', '2004-11-08', 'Rua da Paz, 303', '(41) 94444-1414'),
(7, 4, 'Gabriel Santos', '2005-02-25', 'Rua do Sol, 404', '(41) 93333-1515'),
(8, 4, 'Helena Oliveira', '2004-05-19', 'Rua do Rio, 505', '(41) 92222-1616'),
(9, 5, 'Igor Martins', '2005-08-13', 'Rua da Alegria, 606', '(41) 91111-1717'),
(10, 5, 'Juliana Ferreira', '2004-12-02', 'Rua do Campo, 707', '(41) 90000-1818');

-- Inserir livros na tabela escola.livros
INSERT INTO escola.livros (id_livro, nome, autor, id_disciplina, disponivel) VALUES
(1, 'A Mathematician’s Apology', 'G.H. Hardy', 1, TRUE),
(2, 'Matemática Divertida e Curiosa', 'Malba Tahan', 1, FALSE),
(3, 'História da Riqueza do Homem', 'Leo Huberman', 2, TRUE),
(4, 'Sapiens: Uma Breve História da Humanidade', 'Yuval Noah Harari', 2, FALSE),
(5, 'Biologia', 'Neil A. Campbell', 3, TRUE),
(6, 'A Biologia de Lynn Margulis', 'Lynn Margulis', 3, FALSE),
(7, 'Química: A Ciência Central', 'Theodore L. Brown', 4, TRUE),
(8, 'Química Orgânica', 'Paula Yurkanis Bruice', 4, FALSE);

-- Inserir notas na tabela escola.notas
INSERT INTO escola.notas (id_nota, id_aluno, id_disciplina, teste1, teste2, teste3, teste4) VALUES
(1, 1, 1, 8.0, 7.5, 9.0, 8.5),   
(2, 1, 2, 7.0, 8.0, 8.5, 9.0),   
(3, 1, 3, 8.5, 7.5, 9.0, 8.0),   
(4, 1, 4, 7.0, 6.5, 8.0, 7.5),   
(5, 2, 1, 6.5, 7.0, 6.0, 7.5),   
(6, 2, 2, 7.0, 7.5, 8.0, 6.5),   
(7, 2, 3, 7.5, 8.0, 8.5, 9.0),   
(8, 2, 4, 6.0, 6.5, 7.0, 7.5),   
(9, 3, 1, 8.0, 7.5, 8.5, 9.0),   
(10, 3, 2, 8.0, 7.0, 7.5, 8.0),   
(11, 3, 3, 9.0, 8.5, 8.0, 9.0),   
(12, 3, 4, 7.5, 8.0, 6.5, 7.0),   
(13, 4, 1, 7.0, 8.0, 7.5, 6.5),   
(14, 4, 2, 6.5, 7.0, 7.5, 8.0),   
(15, 4, 3, 8.0, 8.5, 7.0, 7.5),   
(16, 4, 4, 6.0, 7.0, 6.5, 8.0);   

-- Inserir professores na tabela escola.professores
INSERT INTO escola.professores (id_professor, nome, telefone, id_disciplina) VALUES
(1, 'João Silva', '(41) 99999-1111', 1),
(2, 'Maria Oliveira', '(41) 99999-2222', 2),
(3, 'Carlos Pereira', '(41) 99999-3333', 3),
(4, 'Fernanda Costa', '(41) 99999-4444', 4);

-- Inserir salas na tabela escola.salas
INSERT INTO escola.salas (id_sala, nome_sala, curso, numero_de_alunos) VALUES
(1, 'TADS2023', 'TADS', 30),
(2, 'TADS2022', 'TADS', 25),
(3, 'INFO2019', 'INFO', 35),
(4, 'INFO20203', 'INFO', 20),
(5, 'ALIMENTOS2020', 'ALIMENTOS', 20),
(6, 'ALIMENTOS2003', 'ALIMENTOS', 20);

----------------------------------------------------------------------------------------------------------------------
-- 1. Selecionar todos os alunos e suas respectivas salas
SELECT a.nome AS aluno, s.nome_sala AS sala
FROM escola.alunos a
JOIN escola.salas s ON a.id_sala = s.id_sala;

-- 2. Selecionar livros disponíveis e seus respectivos autores
SELECT nome, autor
FROM escola.livros
WHERE disponivel = TRUE;

-- 3. Mostrar o nome dos alunos e suas notas em Matemática (id_disciplina = 1)
SELECT a.nome AS  Nota_de_matematica_do, n.teste1, n.teste2, n.teste3, n.teste4
FROM escola.alunos a
JOIN escola.notas n ON a.id_aluno = n.id_aluno
WHERE n.id_disciplina = 1;

-- 4. Listar todas as disciplinas e a quantidade de livros disponíveis para cada uma
SELECT d.nome_disciplina, COUNT(l.id_livro) AS quantidade_livros
FROM escola.disciplinas d
LEFT JOIN escola.livros l ON d.id_disciplina = l.id_disciplina
GROUP BY d.nome_disciplina;

-- 5. Selecionar o nome e telefone dos professores que lecionam Química (id_disciplina = 4)
SELECT p.nome, p.telefone
FROM escola.professores p
WHERE p.id_disciplina = 4;

-- 6. Mostrar a nota final média dos alunos em cada disciplina
SELECT d.nome_disciplina,
       AVG((n.teste1 + n.teste2 + n.teste3 + n.teste4) / 4.0) AS media_final
FROM escola.notas n
JOIN escola.disciplinas d ON n.id_disciplina = d.id_disciplina
GROUP BY d.nome_disciplina;

-- 7. Encontrar os alunos que têm mais de uma nota registrada
SELECT a.nome
FROM escola.alunos a
JOIN escola.notas n ON a.id_aluno = n.id_aluno
GROUP BY a.nome
HAVING COUNT(n.id_nota) > 1;

-- 8. Calcular a média geral das notas de um aluno específico (por exemplo, id_aluno = 1)
SELECT a.nome,
       AVG((n.teste1 + n.teste2 + n.teste3 + n.teste4) / 4.0) AS media_final
FROM escola.alunos a
JOIN escola.notas n ON a.id_aluno = n.id_aluno
WHERE a.id_aluno = 1;

-- 9. Mostrar a quantidade total de alunos por sala
SELECT s.nome_sala, COUNT(a.id_aluno) AS total_alunos
FROM escola.salas s
LEFT JOIN escola.alunos a ON s.id_sala = a.id_sala
GROUP BY s.nome_sala;

-- 10. Listar os livros e suas respectivas disciplinas, mostrando apenas livros disponíveis
SELECT l.nome, d.nome_disciplina
FROM escola.livros l
JOIN escola.disciplinas d ON l.id_disciplina = d.id_disciplina
WHERE l.disponivel = TRUE;

-- 11. Mostrar a nota final de cada aluno em cada disciplina (média dos testes)
SELECT a.nome AS aluno,
       d.nome_disciplina,
       (n.teste1 + n.teste2 + n.teste3 + n.teste4) / 4.0 AS nota_final
FROM escola.alunos a
JOIN escola.notas n ON a.id_aluno = n.id_aluno
JOIN escola.disciplinas d ON n.id_disciplina = d.id_disciplina;

-- 12. Selecionar os alunos e suas notas mais altas em qualquer teste
SELECT a.nome, MAX(GREATEST(n.teste1, n.teste2, n.teste3, n.teste4)) AS nota_maxima
FROM escola.alunos a
JOIN escola.notas n ON a.id_aluno = n.id_aluno
GROUP BY a.nome;

-- 13. Listar os professores que não estão associados a nenhuma disciplina
SELECT nome
FROM escola.professores
WHERE id_disciplina IS NULL;

-- 14. Mostrar os alunos que têm um endereço que contém "Rua"
SELECT nome, endereco
FROM escola.alunos
WHERE endereco LIKE '%Rua%';

-- 15. Selecionar todos os livros e suas disciplinas, incluindo livros não disponíveis
SELECT l.nome AS livro, d.nome_disciplina
FROM escola.livros l
LEFT JOIN escola.disciplinas d ON l.id_disciplina = d.id_disciplina;

-- 16. Obter nomes dos alunos e suas notas em Matemática
SELECT a.nome AS aluno, n.teste1, n.teste2, n.teste3, n.teste4
FROM escola.alunos a
JOIN escola.notas n ON a.id_aluno = n.id_aluno
JOIN escola.disciplinas d ON n.id_disciplina = d.id_disciplina
WHERE d.nome_disciplina = 'Matemática';

-- 17. Obter nomes dos professores e as disciplinas que eles lecionam
SELECT p.nome AS professor, d.nome_disciplina
FROM escola.professores p
JOIN escola.disciplinas d ON p.id_disciplina = d.id_disciplina;

-- 18. Obter nomes dos alunos e suas salas
SELECT a.nome AS aluno, s.nome_sala
FROM escola.alunos a
JOIN escola.salas s ON a.id_sala = s.id_sala;

-- 19. Obter livros e seus autores junto com a área da disciplina
SELECT l.nome AS livro, l.autor, d.area
FROM escola.livros l
JOIN escola.disciplinas d ON l.id_disciplina = d.id_disciplina;

-- 20. Obter a lista de alunos com suas respectivas notas e os nomes das disciplinas, incluindo a nota final
SELECT a.nome AS aluno, d.nome_disciplina, 
       n.teste1, n.teste2, n.teste3, n.teste4,
       ROUND((n.teste1 + n.teste2 + n.teste3 + n.teste4) / 4, 2) AS nota_final
FROM escola.alunos a
JOIN escola.notas n ON a.id_aluno = n.id_aluno
JOIN escola.disciplinas d ON n.id_disciplina = d.id_disciplina;