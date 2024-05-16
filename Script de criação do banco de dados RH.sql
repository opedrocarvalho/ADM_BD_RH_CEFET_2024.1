CREATE TYPE "genero" AS ENUM (
  'Masculino',
  'Feminino',
  'Não-binário',
  'Agênero',
  'Gênero fluido',
  'Bigênero',
  'Outro',
  'Prefiro não informar'
);

CREATE TYPE "tipo_documento" AS ENUM (
  'RG',
  'CPF',
  'CNH',
  'Carteira de Trabalho',
  'Documento Militar',
  'RNE',
  'PIS'
);

CREATE TYPE "tipo_beneficio" AS ENUM (
  'Plano de Saúde',
  'Seguro de Vida',
  'Assistência Psicológica',
  'Vale-Alimentação',
  'Vale-Refeição',
  'Participação nos lucros',
  'Previdência Privada',
  'Gympass'
);

CREATE TYPE "tipo_pessoa" AS ENUM (
  'Jurídica',
  'Física'
);

CREATE TYPE "tipo_beneficiado" AS ENUM (
  'Cônjuge',
  'Filho',
  'Pai',
  'Mãe',
  'Avô',
  'Avó',
  'Funcionário'
);

CREATE TABLE "endereco" (
  "id_endereco" serial PRIMARY KEY,
  "cep" varchar,
  "logradouro" varchar,
  "numero" int,
  "complemento" int,
  "bairro" varchar,
  "cidade" varchar,
  "estado" varchar
);

CREATE TABLE "usuario" (
  "id_usuario" serial PRIMARY KEY,
  "responsavel" integer,
  "nome_completo" varchar,
  "telefone" varchar,
  "email" varchar,
  "naturalidade" varchar,
  "genero" genero,
  "data_nascimento" date,
  "id_endereco" integer,
  FOREIGN KEY ("id_endereco") REFERENCES "endereco" ("id_endereco"),
  FOREIGN KEY ("responsavel") REFERENCES "usuario" ("id_usuario")
);

CREATE TABLE "empresa" (
  "id_empresa" serial PRIMARY KEY,
  "nome_empresa" varchar,
  "cnpj" varchar,
  "telefone" varchar,
  "email" varchar,
  "id_endereco" integer,
  FOREIGN KEY ("id_endereco") REFERENCES "endereco" ("id_endereco")
);

CREATE TABLE "cargo" (
  "id_cargo" serial PRIMARY KEY,
  "descricao" varchar,
  "salario" float,
  "hierarquia" varchar,
  "carga_horaria" interval
);

CREATE TABLE "funcionario" (
  "matricula" serial PRIMARY KEY,
  "data_admissao" date,
  "data_demissao" date,
  "motivo_demissao" varchar,
  "id_empresa" integer,
  "id_cargo" integer,
  "id_usuario" integer,
  FOREIGN KEY ("id_empresa") REFERENCES "empresa" ("id_empresa"),
  FOREIGN KEY ("id_cargo") REFERENCES "cargo" ("id_cargo"),
  FOREIGN KEY ("id_usuario") REFERENCES "usuario" ("id_usuario")
);

CREATE TABLE "beneficio" (
  "id_beneficio" serial PRIMARY KEY,
  "beneficiado" tipo_beneficiado,
  "tipo" tipo_beneficio,
  "valor" float,
  "id_usuario" integer,
  FOREIGN KEY ("id_usuario") REFERENCES "usuario" ("id_usuario")
);

CREATE TABLE "ferias" (
  "id_ferias" serial PRIMARY KEY,
  "matricula" integer,
  "data_entrada" date,
  "data_retorno" date,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "documento" (
  "id_documento" serial PRIMARY KEY,
  "id_usuario" integer,
  "tipo" tipo_documento,
  "numero" varchar,
  "emissao" date,
  "validade" date,
  FOREIGN KEY ("id_usuario") REFERENCES "usuario" ("id_usuario")
);

CREATE TABLE "setor" (
  "id_setor" serial PRIMARY KEY,
  "matricula" integer,
  "nome_setor" varchar,
  "responsavel" varchar,
  "id_empresa" integer,
  FOREIGN KEY ("id_empresa") REFERENCES "empresa" ("id_empresa"),
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "contra_cheque" (
  "id_contra_cheque" serial PRIMARY KEY,
  "matricula" integer,
  "bonus" float,
  "pessoa" tipo_pessoa,
  "desconto" float,
  "razao_desconto" varchar,
  "data_pagamento" date,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "registro_horas" (
  "id_registro" serial PRIMARY KEY,
  "matricula" integer,
  "data" date,
  "hora_entrada" time,
  "hora_saida" time,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "avaliacao" (
  "id_avaliacao" serial PRIMARY KEY,
  "matricula" integer,
  "avaliador" varchar,
  "data_avaliacao" date,
  "nota" integer,
  "competencia" varchar,
  "comentarios" varchar,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

