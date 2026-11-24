CREATE DATABASE IF NOT EXISTS oficina_mecanica;
USE oficina_mecanica;

-- 1. Tabela de Clientes
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf_cnpj VARCHAR(18) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    endereco VARCHAR(255)
);

-- 2. Tabela de Veículos (1 Cliente pode ter N Veículos)
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    placa VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    ano INT,
    CONSTRAINT fk_veiculo_cliente FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente) ON DELETE CASCADE
);

-- 3. Tabela de Equipes (A equipe avaliará e executará os serviços)
CREATE TABLE Equipe (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe VARCHAR(100) NOT NULL
);

-- 4. Tabela de Mecânicos (1 Equipe pode ter N Mecânicos)
CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    id_equipe INT NOT NULL,
    codigo_mecanico VARCHAR(20) NOT NULL UNIQUE,
    nome VARCHAR(150) NOT NULL,
    endereco VARCHAR(255),
    especialidade VARCHAR(100),
    CONSTRAINT fk_mecanico_equipe FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

-- 5. Tabela de Ordem de Serviço (OS)
CREATE TABLE OS (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    id_veiculo INT NOT NULL,
    id_equipe INT NOT NULL,
    numero_os VARCHAR(20) NOT NULL UNIQUE,
    data_emissao DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_conclusao DATETIME,
    valor_total DECIMAL(10,2) DEFAULT 0.00,
    status_os ENUM('Orçamento', 'Aguardando_Aprovacao', 'Aprovada', 'Em_Andamento', 'Concluida', 'Cancelada') DEFAULT 'Orçamento',
    CONSTRAINT fk_os_veiculo FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    CONSTRAINT fk_os_equipe FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

-- 6. Tabela de Referência de Mão-de-Obra (Serviços)
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao_servico VARCHAR(255) NOT NULL,
    valor_mao_obra DECIMAL(10,2) NOT NULL
);

-- 7. Tabela de Referência de Peças
CREATE TABLE Peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao_peca VARCHAR(255) NOT NULL,
    valor_peca DECIMAL(10,2) NOT NULL
);

-- 8. Tabela Relacional (N:M) entre OS e Serviços
CREATE TABLE OS_Servico (
    id_os INT NOT NULL,
    id_servico INT NOT NULL,
    quantidade INT DEFAULT 1,
    valor_subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_servico),
    CONSTRAINT fk_os_servico_os FOREIGN KEY (id_os) REFERENCES OS(id_os) ON DELETE CASCADE,
    CONSTRAINT fk_os_servico_servico FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

-- 9. Tabela Relacional (N:M) entre OS e Peças
CREATE TABLE OS_Peca (
    id_os INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade INT DEFAULT 1,
    valor_subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_os, id_peca),
    CONSTRAINT fk_os_peca_os FOREIGN KEY (id_os) REFERENCES OS(id_os) ON DELETE CASCADE,
    CONSTRAINT fk_os_peca_peca FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);