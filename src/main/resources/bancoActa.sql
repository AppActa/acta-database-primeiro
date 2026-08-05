-- ENUMs
CREATE TYPE status_masculino_enum AS ENUM ('Não iniciado', 'Iniciado', 'Finalizado');
CREATE TYPE status_feminino_enum AS ENUM ('Não iniciada', 'Iniciada', 'Finalizada');
CREATE TYPE status_meta_enum AS ENUM ('Abaixo do esperado', 'Regular', 'Acima do esperado');
CREATE TYPE status_problema_enum AS ENUM ('Em análise', 'Em resolução', 'Resolvido');
CREATE TYPE prioridade_enum AS ENUM ('Alto', 'Médio', 'Baixo');

-- Endereço
CREATE TABLE IF NOT EXISTS endereco (
                                        endereco_id SERIAL PRIMARY KEY,
                                        rua VARCHAR(30) NOT NULL,
                                        bairro VARCHAR(30) NOT NULL,
                                        cidade VARCHAR(30) NOT NULL,
                                        estado VARCHAR(30) NOT NULL,
                                        cep CHAR(8) NOT NULL,
                                        numero VARCHAR(10) NOT NULL,
                                        complemento TEXT
);

-- E-mail
CREATE TABLE IF NOT EXISTS email (
                                     email_id SERIAL PRIMARY KEY,
                                     email VARCHAR(80) NOT NULL
);

-- Telefone
CREATE TABLE IF NOT EXISTS telefone (
                                        telefone_id SERIAL PRIMARY KEY,
                                        telefone CHAR(11) NOT NULL
);

-- Empresa
CREATE TABLE IF NOT EXISTS empresa (
                                       empresa_id SERIAL PRIMARY KEY,
                                       nome VARCHAR(30) NOT NULL,
                                       setor VARCHAR(30),
                                       unidade VARCHAR(30),
                                       endereco_id INT REFERENCES endereco(endereco_id),
                                       cnpj CHAR(14) NOT NULL
);

-- Administrador Geral
CREATE TABLE IF NOT EXISTS administrador_geral (
                                                   adm_geral_id SERIAL PRIMARY KEY,
                                                   nome VARCHAR(30) NOT NULL,
                                                   senha VARCHAR(100) NOT NULL,
                                                   email_id INT NOT NULL REFERENCES email (email_id),
                                                   cpf CHAR(11) NOT NULL
);

-- Administração Empresa
CREATE TABLE IF NOT EXISTS administracao_empresa (
                                                     adm_empresa_id SERIAL PRIMARY KEY,
                                                     nome VARCHAR(30) NOT NULL,
                                                     senha VARCHAR(100) NOT NULL,
                                                     email_id INT NOT NULL REFERENCES email(email_id),
                                                     empresa_id INT NOT NULL REFERENCES empresa(empresa_id),
                                                     cpf CHAR(11) NOT NULL
);

-- Colaborador
CREATE TABLE IF NOT EXISTS colaborador (
                                           colaborador_id SERIAL PRIMARY KEY,
                                           nome VARCHAR(30) NOT NULL,
                                           sobrenome VARCHAR(50) NOT NULL,
                                           permissao_gestor BOOLEAN NOT NULL DEFAULT FALSE,
                                           cargo VARCHAR(30) NOT NULL,
                                           email_id INT NOT NULL REFERENCES email(email_id),
                                           telefone_id INT NOT NULL REFERENCES telefone(telefone_id),
                                           cpf CHAR(11) NOT NULL
);

-- Projeto
CREATE TABLE IF NOT EXISTS projeto (
                                       projeto_id SERIAL PRIMARY KEY,
                                       nome VARCHAR(30) NOT NULL,
                                       etapa_atual VARCHAR(10) NOT NULL,
                                       dt_inicio DATE NOT NULL,
                                       dt_fim DATE,
                                       status status_masculino_enum NOT NULL DEFAULT 'Não iniciado',
                                       criado_em TIMESTAMPTZ NOT NULL DEFAULT (NOW() AT TIME ZONE 'America/Sao_Paulo')
);

-- Meta
CREATE TABLE IF NOT EXISTS meta (
                                    meta_id SERIAL PRIMARY KEY,
                                    meta VARCHAR(100) NOT NULL,
                                    descricao_meta TEXT,
                                    objetivo VARCHAR(200),
                                    prazo DATE NOT NULL,
                                    status status_meta_enum NOT NULL DEFAULT 'Regular',
                                    criado_em TIMESTAMPTZ NOT NULL DEFAULT (NOW() AT TIME ZONE 'America/Sao_Paulo'),
                                    projeto_id INT NOT NULL REFERENCES projeto(projeto_id)
);

-- Plano de Ação
CREATE TABLE IF NOT EXISTS plano_acao (
                                          plano_acao_id SERIAL PRIMARY KEY,
                                          nome VARCHAR(20) NOT NULL,
                                          descricao TEXT,
                                          status status_masculino_enum NOT NULL DEFAULT 'Não iniciado',
                                          prioridade prioridade_enum NOT NULL DEFAULT 'Médio',
                                          projeto_id INT NOT NULL REFERENCES projeto(projeto_id)
);

-- 5W2H
CREATE TABLE IF NOT EXISTS plano_acao5w2h (
                                              plano_acao_5w2h_id SERIAL PRIMARY KEY,
                                              what VARCHAR(50) NOT NULL,
                                              why VARCHAR(50),
                                              where VARCHAR(50),
                                              when DATE,
                                              who VARCHAR(50),
                                              how VARCHAR(50),
                                              how_much VARCHAR(50),
                                              plano_acao_id INT NOT NULL REFERENCES plano_acao(plano_acao_id)
);

-- Tarefa
CREATE TABLE IF NOT EXISTS tarefa (
                                      tarefa_id SERIAL PRIMARY KEY,
                                      titulo VARCHAR(20) NOT NULL,
                                      descricao TEXT,
                                      prioridade prioridade_enum NOT NULL DEFAULT 'Médio',
                                      dt_entrega DATE,
                                      status status_feminino_enum NOT NULL DEFAULT 'Não iniciada',
                                      dt_inicio DATE NOT NULL,
                                      colaborador_id INT NOT NULL REFERENCES colaborador(colaborador_id)
);

-- Lições Aprendidas
CREATE TABLE IF NOT EXISTS licoes_aprendidas (
                                                 licao_id SERIAL PRIMARY KEY,
                                                 titulo VARCHAR(50) NOT NULL,
                                                 area VARCHAR(30),
                                                 aprendizado TEXT NOT NULL,
                                                 categoria VARCHAR(30),
                                                 descricao TEXT,
                                                 fase_origem VARCHAR(8),
                                                 severidade VARCHAR(50),
                                                 colaborador_id INT NOT NULL REFERENCES colaborador(colaborador_id)
);

-- Problema
CREATE TABLE IF NOT EXISTS problema (
                                        problema_id SERIAL PRIMARY KEY,
                                        titulo VARCHAR(100) NOT NULL,
                                        descricao TEXT NOT NULL,
                                        solucao VARCHAR(200),
                                        status status_problema_enum NOT NULL DEFAULT 'Em análise',
                                        origem TEXT,
                                        encontrado_em DATE NOT NULL,
                                        projeto_id INT NOT NULL REFERENCES projeto(projeto_id),
                                        plano_acao_id INT REFERENCES plano_acao(plano_acao_id)
);

-- Relacionamentos N:N

CREATE TABLE IF NOT EXISTS projeto_colaborador (
                                                   projeto_id INT NOT NULL REFERENCES projeto (projeto_id),
                                                   colaborador_id INT NOT NULL REFERENCES colaborador (colaborador_id),
                                                   PRIMARY KEY (projeto_id, colaborador_id)
);

CREATE TABLE IF NOT EXISTS projeto_plano_acao (
                                                  projeto_id INT NOT NULL REFERENCES projeto (projeto_id),
                                                  plano_acao_id INT NOT NULL REFERENCES plano_acao (plano_acao_id),
                                                  PRIMARY KEY (projeto_id, plano_acao_id)
);

CREATE TABLE IF NOT EXISTS tarefa_plano_acao (
                                                 tarefa_id INT NOT NULL REFERENCES tarefa (tarefa_id),
                                                 plano_acao_id INT NOT NULL REFERENCES plano_acao (plano_acao_id),
                                                 PRIMARY KEY (tarefa_id, plano_acao_id)
);

CREATE TABLE IF NOT EXISTS empresa_administrador_geral (
                                                           empresa_id INT NOT NULL REFERENCES empresa (empresa_id),
                                                           adm_geral_id INT NOT NULL REFERENCES administrador_geral (adm_geral_id),
                                                           PRIMARY KEY (empresa_id, adm_geral_id)
);

ALTER TABLE endereco
ADD CONSTRAINT chk_cep_tamanho CHECK (length(cep)=8);

ALTER TABLE telefone
ADD CONSTRAINT chk_tamanho_telefone CHECK (length(telefone)=11);

ALTER TABLE empresa
ADD CONSTRAINT chk_cnpj_empresa CHECK (length(cnpj)=14);

ALTER TABLE administrador_geral
ADD CONSTRAINT chk_cpf_adm_geral CHECK ( length(cpf)=11);

ALTER TABLE administracao_empresa
ADD CONSTRAINT chk_cpf_adm_empresa CHECK ( length(cpf)=11);

ALTER TABLE colaborador
ADD CONSTRAINT chk_cpf_colab CHECK ( length(cpf)=11);

ALTER TABLE projeto
ADD CONSTRAINT chk_dt_inicio CHECK ( dt_inicio>=current_date);

ALTER TABLE projeto
ADD CONSTRAINT chk_dt_fim CHECK (dt_fim>=dt_inicio);

ALTER TABLE meta
ADD CONSTRAINT chk_prazo CHECK ( prazo>=current_date);

ALTER TABLE plano_acao5w2h
ADD CONSTRAINT chk_when CHECK ( plano_acao5w2h.when <= current_date);

ALTER TABLE tarefa
ADD CONSTRAINT chk_dt_entrega CHECK (dt_entrega>=current_date);

ALTER TABLE tarefa
ADD CONSTRAINT chk_dt_inicio CHECK (dt_inicio>=current_date);