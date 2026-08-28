-- SCRIPT DATA LOAD


-- Endereço
INSERT INTO endereco (rua, bairro, cidade, estado, cep, numero, complemento)
VALUES ('Avenida Mutinga', 'Pirituba', 'São Paulo', 'São Paulo', '09234000', '2300', 'Escritório 4');

INSERT INTO endereco (rua, bairro, cidade, estado, cep, numero, complemento)
VALUES ('Rua das Palmeiras', 'Savassi', 'Belo Horizonte', 'Minas Gerais', '30130170', '512', 'Sala 8');

INSERT INTO endereco (rua, bairro, cidade, estado, cep, numero, complemento)
VALUES ('Rua Machado', 'Industrial', 'Betim', 'Minas Gerais', '32677000', '150', 'Galpão 2');

-- Empresa
INSERT INTO empresa (nome, setor, unidade, endereco_id, cnpj)
VALUES ('Âmbar Energia', 'Elétrico', 'Mutinga', 1, '67423601000188');

INSERT INTO empresa (nome, setor, unidade, endereco_id, cnpj)
VALUES ('Friboi', 'Alimentício - Carnes', 'Savassi', 2, '19583726000144');

INSERT INTO empresa (nome, setor, unidade, endereco_id, cnpj)
VALUES ('Seara Alimentos', 'Alimentício', 'Betim', 3, '48273910000156');

-- Administrador Geral
INSERT INTO administrador_geral (nome, senha, email, telefone)
VALUES ('Roberson', 'souAdmdaAmbar1234', 'roberson.silva@ambarenergia.com.br', '11348394736');

INSERT INTO administrador_geral (nome, senha, email, telefone)
VALUES ('Fernanda', 'friboiAdm2026', 'fernanda.lopes@jbsfriboi.com.br', '31998475632');

INSERT INTO administrador_geral (nome, senha, email, telefone)
VALUES ('Patrícia', 'jbsAdmSeara25', 'patricia.gomes@jbsseara.com.br', '11976543210');

-- Colaborador
INSERT INTO colaborador (nome, sobrenome, cargo, email, telefone, cpf, empresa_id)
VALUES ('José', 'Amorim Martins', 'Técnico eletricista', 'amorimar.jose@ambarenergia.org.br', '11483058338', '98457908658', 1);

INSERT INTO colaborador (nome, sobrenome, cargo, email, telefone, cpf, empresa_id)
VALUES ('Camila', 'Duarte Rocha', 'Técnica de Segurança do Trabalho', 'camila.rocha@jbsfriboi.com.br', '31976583421', '65498732014', 2);

INSERT INTO colaborador (nome, sobrenome, cargo, email, telefone, cpf, empresa_id)
VALUES ('Rafael', 'Costa Almeida', 'Supervisor de Produção', 'rafael.almeida@jbsseara.com.br', '11987654321', '52698471033', 3);

-- Ciclo
INSERT INTO ciclo (nome, dt_inicio)
VALUES ('PDCA para algum problema', current_date);

INSERT INTO ciclo (nome, dt_inicio)
VALUES ('PDCA redução de acidentes de trabalho na planta industrial', '2026-09-01');

INSERT INTO ciclo (nome, dt_inicio)
VALUES ('PDCA redução de desperdício na linha de produção', '2026-09-10');

-- Meta
INSERT INTO meta (meta, descricao_meta, objetivo, prazo, ciclo_id)
VALUES ('tensão da energia', 'blablablabla', 'Controlar a oscilação de tensão', '2026-11-30', 1);

INSERT INTO meta (meta, descricao_meta, objetivo, prazo, ciclo_id)
VALUES ('acidentes de trabalho', 'redução de incidentes registrados na operação', 'Zerar acidentes graves até o fim do ano', '2026-12-20', 2);

INSERT INTO meta (meta, descricao_meta, objetivo, prazo, ciclo_id)
VALUES ('desperdício de matéria-prima', 'redução de perdas na linha de produção', 'Reduzir desperdício em 20%', '2026-12-10', 3);

-- Plano de ação
INSERT INTO plano_acao (nome, descricao, ciclo_id)
VALUES ('Revisão de tensão', 'Identificar causas da oscilação de tensão na rede', 1);

INSERT INTO plano_acao (nome, descricao, ciclo_id)
VALUES ('Reforço de EPI', 'Reforçar uso obrigatório de equipamentos de proteção', 2);

INSERT INTO plano_acao (nome, descricao, ciclo_id)
VALUES ('Otimização de linha', 'Reduzir desperdício de matéria-prima na produção', 3);

-- 5W2H
INSERT INTO plano_acao5w2h (what, why, "where", "when", who, how, how_much, plano_acao_id)
VALUES ('Inspecionar transformadores', 'Reduzir oscilação de tensão', 'Subestação Mutinga', '2026-08-20', 'José Amorim Martins', 'Inspeção visual e testes de carga', 'R$ 3.200,00', 1);

INSERT INTO plano_acao5w2h (what, why, "where", "when", who, how, how_much, plano_acao_id)
VALUES ('Auditar uso de EPI', 'Reduzir número de acidentes na planta', 'Linha de abate', '2026-08-25', 'Camila Duarte Rocha', 'Vistoria diária com checklist', 'R$ 1.500,00', 2);

INSERT INTO plano_acao5w2h (what, why, "where", "when", who, how, how_much, plano_acao_id)
VALUES ('Revisar processo de corte', 'Reduzir desperdício de matéria-prima', 'Linha de produção 2', '2026-08-24', 'Rafael Costa Almeida', 'Treinamento e ajuste de máquinas', 'R$ 2.800,00', 3);

-- Tarefa
INSERT INTO tarefa (titulo, descricao, dt_entrega, colaborador_id)
VALUES ('Inspecionar transformador', 'Verificar estado dos transformadores da subestação', '2026-09-15', 1);

INSERT INTO tarefa (titulo, descricao, dt_entrega, colaborador_id)
VALUES ('Vistoriar EPI', 'Checar uso correto de EPI pelos operadores da linha de abate', '2026-09-10', 2);

INSERT INTO tarefa (titulo, descricao, dt_entrega, colaborador_id)
VALUES ('Revisar linha 2', 'Ajustar máquinas de corte para reduzir desperdício', '2026-09-20', 3);

-- Lições Aprendidas
INSERT INTO licoes_aprendidas (titulo, area, aprendizado, categoria, descricao, fase_origem, severidade, ciclo_id)
VALUES ('Falha de monitoramento', 'Elétrica', 'Necessário monitoramento contínuo de tensão', 'Processo', 'Oscilações não foram detectadas a tempo', 'DO', 'Alta', 1);

INSERT INTO licoes_aprendidas (titulo, area, aprendizado, categoria, descricao, fase_origem, severidade, ciclo_id)
VALUES ('Uso irregular de EPI', 'Segurança', 'Fiscalização precisa ser diária e não semanal', 'Segurança do Trabalho', 'Vistorias semanais não identificaram uso incorreto a tempo', 'PLAN', 'Alta', 2);

INSERT INTO licoes_aprendidas (titulo, area, aprendizado, categoria, descricao, fase_origem, severidade, ciclo_id)
VALUES ('Desperdício por má calibração', 'Produção', 'Necessário calibrar máquinas semanalmente', 'Processo', 'Máquinas descalibradas geravam perdas de matéria-prima', 'CHECK', 'Média', 3);

-- Problema
INSERT INTO problema (titulo, descricao, solucao, status, origem, encontrado_em, ciclo_id, plano_acao_id)
VALUES ('Oscilação de tensão na rede', 'Consumidores reportaram variações de tensão frequentes', 'Substituição de transformador defeituoso', 'EM_ANALISE', 'Reclamação de clientes', '2026-08-25', 1, 1);

INSERT INTO problema (titulo, descricao, solucao, status, origem, encontrado_em, ciclo_id, plano_acao_id)
VALUES ('Aumento de quase-acidentes na planta industrial', 'Registro elevado de quase-acidentes na linha de abate', 'Reforço de treinamento e fiscalização de EPI', 'EM_RESOLUCAO', 'Relatório interno de segurança', '2026-08-28', 2, 2);

INSERT INTO problema (titulo, descricao, solucao, status, origem, encontrado_em, ciclo_id, plano_acao_id)
VALUES ('Alto desperdício de matéria-prima', 'Linha de produção 2 apresenta perdas acima do esperado', 'Calibração e treinamento da equipe', 'EM_RESOLUCAO', 'Auditoria interna de produção', '2026-08-20', 3, 3);

-- Ciclo_Colaborador
INSERT INTO ciclo_colaborador (ciclo_id, colaborador_id)
VALUES (1, 1);

INSERT INTO ciclo_colaborador (ciclo_id, colaborador_id)
VALUES (2, 2);

INSERT INTO ciclo_colaborador (ciclo_id, colaborador_id)
VALUES (3, 3);

-- Empresa_Administrador_Geral
INSERT INTO empresa_administrador_geral (empresa_id, adm_geral_id)
VALUES (1, 1);

INSERT INTO empresa_administrador_geral (empresa_id, adm_geral_id)
VALUES (2, 2);

INSERT INTO empresa_administrador_geral (empresa_id, adm_geral_id)
VALUES (3, 3);