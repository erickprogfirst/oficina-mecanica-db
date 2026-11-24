USE oficina_mecanica;

-- 1. Inserir Clientes
INSERT INTO Cliente (nome, cpf_cnpj, telefone, endereco) VALUES
('Carlos Eduardo Mendes', '123.456.789-01', '(47) 99111-2233', 'Rua Amazonas, 450 - Blumenau, SC'),
('Fernanda Lima Souza', '234.567.890-12', '(47) 99222-3344', 'Rua Bahia, 1200 - Blumenau, SC'),
('Transportadora Vale Log LTDA', '12.345.678/0001-90', '(47) 3322-4455', 'BR-470, Km 52 - Blumenau, SC');

-- 2. Inserir Veículos (Cliente 3 possui dois veículos)
INSERT INTO Veiculo (id_cliente, placa, marca, modelo, ano) VALUES
(1, 'ABC1D23', 'Volkswagen', 'Golf TSI', 2020),
(2, 'DEF4G56', 'Honda', 'Civic Touring', 2022),
(3, 'GHI7J89', 'Fiat', 'Fiorino', 2021),
(3, 'JKL0M12', 'Renault', 'Master Furgão', 2023);

-- 3. Inserir Equipes
INSERT INTO Equipe (nome_equipe) VALUES
('Equipe Alfa - Mecânica Pesada e Freios'),
('Equipe Beta - Elétrica e Revisão Preventiva');

-- 4. Inserir Mecânicos
INSERT INTO Mecanico (id_equipe, codigo_mecanico, nome, endereco, especialidade) VALUES
(1, 'MEC-001', 'Roberto Almeida', 'Rua Itajaí, 300 - Blumenau, SC', 'Motor e Transmissão'),
(1, 'MEC-002', 'Marcos Vinícius', 'Rua 2 de Setembro, 890 - Blumenau, SC', 'Suspensão e Freios'),
(2, 'MEC-003', 'Juliano Ferreira', 'Rua São Paulo, 150 - Blumenau, SC', 'Injeção Eletrônica'),
(2, 'MEC-004', 'Tiago Oliveira', 'Rua Frei Estanislau Schaette, 600 - Blumenau, SC', 'Revisão Geral e Elétrica');

-- 5. Inserir Tabela de Referência de Mão-de-Obra (Serviços)
INSERT INTO Servico (descricao_servico, valor_mao_obra) VALUES
('Troca de Óleo e Filtros', 150.00),
('Alinhamento e Balanceamento', 120.00),
('Revisão Completa de Freios', 250.00),
('Diagnóstico Eletrônico e Troca de Bateria', 180.00);

-- 6. Inserir Tabela de Referência de Peças
INSERT INTO Peca (descricao_peca, valor_peca) VALUES
('Óleo Sintético 5W30 (Litro)', 45.00),
('Filtro de Óleo Original', 35.00),
('Jogo de Pastilhas de Freio Dianteiras', 180.00),
('Bateria Automotiva 60Ah', 420.00);

-- 7. Inserir Ordens de Serviço (OS)
-- OS 1: 150 (Serviço) + 180 (4x Óleo) + 35 (Filtro) = 365.00
-- OS 2: 250 (Freios) + 120 (Alinhamento) + 180 (Pastilhas) = 550.00
-- OS 3: 180 (Diagnóstico) + 420 (Bateria) = 600.00
INSERT INTO OS (id_veiculo, id_equipe, numero_os, data_conclusao, valor_total, status_os) VALUES
(1, 2, 'OS-2026-001', '2026-11-20 17:30:00', 365.00, 'Concluida'),
(2, 1, 'OS-2026-002', '2026-11-26 18:00:00', 550.00, 'Em_Andamento'),
(3, 2, 'OS-2026-003', NULL, 600.00, 'Aguardando_Aprovacao');

-- 8. Inserir Serviços das OS (Tabela N:M)
INSERT INTO OS_Servico (id_os, id_servico, quantidade, valor_subtotal) VALUES
(1, 1, 1, 150.00),
(2, 3, 1, 250.00),
(2, 2, 1, 120.00),
(3, 4, 1, 180.00);

-- 9. Inserir Peças das OS (Tabela N:M)
INSERT INTO OS_Peca (id_os, id_peca, quantidade, valor_subtotal) VALUES
(1, 1, 4, 180.00),
(1, 2, 1, 35.00),
(2, 3, 1, 180.00),
(3, 4, 1, 420.00);