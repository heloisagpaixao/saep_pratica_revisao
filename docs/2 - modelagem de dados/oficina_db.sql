SELECT VERSION();
CREATE DATABASE IF NOT EXISTS oficina_db;
USE oficina_db;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_criptografado VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha_criptografada VARCHAR(255) NOT NULL
);

CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_criptografado VARCHAR(255) NOT NULL,
    telefone VARCHAR(15) NOT NULL, -- Ajustado para VARCHAR para suportar DDD e zero à esquerda
    fk_id_usuario INT NOT NULL,
    FOREIGN KEY (fk_id_usuario) REFERENCES usuarios(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE veiculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) NOT NULL UNIQUE,
    modelo VARCHAR(50) NOT NULL,
    marca VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    fk_id_cliente INT NOT NULL,
    FOREIGN KEY (fk_id_cliente) REFERENCES clientes(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE agendamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_agendamento DATE NOT NULL,
    horario TIME NOT NULL,
    servico VARCHAR(255) NOT NULL, -- Recomendado VARCHAR para descrição do serviço
    fk_id_veiculo INT NOT NULL,
    FOREIGN KEY (fk_id_veiculo) REFERENCES veiculos(id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- ==============================================================================
-- INSERÇÃO DE DADOS DE TESTE
-- ==============================================================================

INSERT INTO usuarios (nome, cpf_criptografado, email, senha_criptografada) VALUES
('admin', 'enc_cpf_11122233304', 'admin@oficina.com', '2b10$jW8ZqNZFxgZzmukC950z3uuzwz.Eo9dxx2D7CCQwAvmFNzReZwd0u');

INSERT INTO clientes (nome, cpf_criptografado, telefone, fk_id_usuario) VALUES
('João Pereira', 'U2FsdGVkX1+vG8/f8vX339vX001aBC', '(11) 98765-4321', 1),
('Maria Oliveira', 'U2FsdGVkX1+vG8/f8vX339vX002bCD', '(11) 91234-5678', 1),
('Lucas Rodrigues', 'U2FsdGVkX1+vG8/f8vX339vX003cDE', '(11) 95555-4444', 1);

INSERT INTO veiculos (placa, modelo, marca, ano, fk_id_cliente) VALUES
('ABC-1234', 'Civic', 'Honda', 2020, 1),
('XYZ-5678', 'Corolla', 'Toyota', 2021, 2),
('KLM-9012', 'Onix', 'Chevrolet', 2019, 3);

INSERT INTO agendamentos (data_agendamento, horario, servico, fk_id_veiculo) VALUES
('2026-11-10', '08:00:00', 'Troca de Óleo e Filtro', 1),
('2026-11-10', '10:30:00', 'Alinhamento e Balanceamento', 2),
('2026-11-11', '14:00:00', 'Revisão dos Freios', 3);
