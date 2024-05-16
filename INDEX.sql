CREATE INDEX idx_endereco_cep ON "endereco" ("cep");
CREATE INDEX idx_endereco_cidade ON "endereco" ("cidade");
CREATE INDEX idx_endereco_estado ON "endereco" ("estado");

CREATE INDEX idx_usuario_nome_completo ON "usuario" ("nome_completo");
CREATE INDEX idx_usuario_telefone ON "usuario" ("telefone");
CREATE INDEX idx_usuario_email ON "usuario" ("email");
CREATE INDEX idx_usuario_id_endereco ON "usuario" ("id_endereco");

CREATE INDEX idx_empresa_nome_empresa ON "empresa" ("nome_empresa");
CREATE INDEX idx_empresa_cnpj ON "empresa" ("cnpj");
CREATE INDEX idx_empresa_id_endereco ON "empresa" ("id_endereco");

CREATE INDEX idx_cargo_descricao ON "cargo" ("descricao");

CREATE INDEX idx_funcionario_id_empresa ON "funcionario" ("id_empresa");
CREATE INDEX idx_funcionario_id_cargo ON "funcionario" ("id_cargo");
CREATE INDEX idx_funcionario_id_usuario ON "funcionario" ("id_usuario");

CREATE INDEX idx_beneficio_tipo ON "beneficio" ("tipo");
CREATE INDEX idx_beneficio_id_usuario ON "beneficio" ("id_usuario");

CREATE INDEX idx_ferias_matricula ON "ferias" ("matricula");

CREATE INDEX idx_documento_tipo ON "documento" ("tipo");
CREATE INDEX idx_documento_id_usuario ON "documento" ("id_usuario");

CREATE INDEX idx_setor_nome_setor ON "setor" ("nome_setor");
CREATE INDEX idx_setor_id_empresa ON "setor" ("id_empresa");

CREATE INDEX idx_contra_cheque_id_funcionario ON "contra_cheque" ("matricula");

CREATE INDEX idx_registro_horas_data ON "registro_horas" ("data");
CREATE INDEX idx_registro_horas_matricula ON "registro_horas" ("matricula");

CREATE INDEX idx_avaliacao_data_avaliacao ON "avaliacao" ("data_avaliacao");
CREATE INDEX idx_avaliacao_matricula ON "avaliacao" ("matricula");
