USE oficina_mecanica;

-- 1. Relatório Geral de Ordens de Serviço (Visão Gerencial)
-- Lista cada OS com os dados do cliente, veículo, equipe responsável e status atual.
SELECT 
    os.numero_os,
    os.status_os,
    c.nome AS cliente,
    CONCAT(v.marca, ' ', v.modelo, ' (', v.placa, ')') AS veiculo,
    e.nome_equipe AS equipe_responsavel,
    os.valor_total,
    os.data_emissao,
    os.data_conclusao
FROM OS os
JOIN Veiculo v ON os.id_veiculo = v.id_veiculo
JOIN Cliente c ON v.id_cliente = c.id_cliente
JOIN Equipe e ON os.id_equipe = e.id_equipe
ORDER BY os.data_emissao DESC;

-- 2. Desempenho e Faturamento por Equipe
-- Avalia quantas OS cada equipe atendeu e o valor total gerado (exceto canceladas).
SELECT 
    e.nome_equipe,
    COUNT(os.id_os) AS total_os,
    SUM(os.valor_total) AS faturamento_gerado,
    ROUND(AVG(os.valor_total), 2) AS ticket_medio_os
FROM Equipe e
LEFT JOIN OS os ON e.id_equipe = os.id_equipe AND os.status_os != 'Cancelada'
GROUP BY e.id_equipe, e.nome_equipe
ORDER BY faturamento_gerado DESC;

-- 3. Clientes com Frota (Mais de 1 Veículo Cadastrado)
-- Identifica clientes com potencial para contratos de manutenção recorrente (B2B/Frotas).
SELECT 
    c.nome AS cliente,
    c.cpf_cnpj,
    COUNT(v.id_veiculo) AS quantidade_veiculos
FROM Cliente c
JOIN Veiculo v ON c.id_cliente = v.id_cliente
GROUP BY c.id_cliente, c.nome, c.cpf_cnpj
HAVING COUNT(v.id_veiculo) > 1
ORDER BY quantidade_veiculos DESC;

-- 4. Detalhamento Financeiro por OS (Mão-de-Obra vs. Peças)
-- Compara quanto de cada OS veio de serviços e quanto veio de peças.
SELECT 
    os.numero_os,
    os.status_os,
    COALESCE((SELECT SUM(oss.valor_subtotal) FROM OS_Servico oss WHERE oss.id_os = os.id_os), 0) AS total_mao_obra,
    COALESCE((SELECT SUM(osp.valor_subtotal) FROM OS_Peca osp WHERE osp.id_os = os.id_os), 0) AS total_pecas,
    os.valor_total AS total_registrado_os
FROM OS os
ORDER BY os.valor_total DESC;

-- 5. Quadro de Mecânicos por Equipe e Especialidade
-- Visão rápida de alocação da equipe técnica da oficina.
SELECT 
    e.nome_equipe,
    m.codigo_mecanico,
    m.nome AS mecanico,
    m.especialidade
FROM Mecanico m
JOIN Equipe e ON m.id_equipe = e.id_equipe
ORDER BY e.nome_equipe, m.nome;