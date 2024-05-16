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
  "cep" varchar NOT NULL,
  "logradouro" varchar,
  "numero" int NOT NULL,
  "complemento" varchar,
  "bairro" varchar,
  "cidade" varchar NOT NULL,
  "estado" varchar NOT NULL
);

CREATE TABLE "usuario" (
  "id_usuario" serial PRIMARY KEY,
  "responsavel" integer,
  "nome_completo" varchar NOT NULL,
  "telefone" varchar NOT NULL,
  "email" varchar,
  "naturalidade" varchar,
  "genero" genero,
  "data_nascimento" date NOT NULL,
  "id_endereco" integer,
  FOREIGN KEY ("id_endereco") REFERENCES "endereco" ("id_endereco"),
  FOREIGN KEY ("responsavel") REFERENCES "usuario" ("id_usuario")
);

CREATE TABLE "empresa" (
  "id_empresa" serial PRIMARY KEY,
  "nome_empresa" varchar NOT NULL,
  "cnpj" varchar NOT NULL,
  "telefone" varchar,
  "email" varchar,
  "id_endereco" integer,
  FOREIGN KEY ("id_endereco") REFERENCES "endereco" ("id_endereco")
);

CREATE TABLE "cargo" (
  "id_cargo" serial PRIMARY KEY,
  "descricao" varchar,
  "salario" float NOT NULL,
  "hierarquia" varchar NOT NULL,
  "carga_horaria" interval
);

CREATE TABLE "funcionario" (
  "matricula" serial PRIMARY KEY,
  "data_admissao" date NOT NULL,
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
  "tipo" tipo_beneficio NOT NULL,
  "valor" float NOT NULL,
  "id_usuario" integer,
  FOREIGN KEY ("id_usuario") REFERENCES "usuario" ("id_usuario")
);

CREATE TABLE "ferias" (
  "id_ferias" serial PRIMARY KEY,
  "matricula" integer,
  "data_entrada" date NOT NULL,
  "data_retorno" date NOT NULL,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "documento" (
  "id_documento" serial PRIMARY KEY,
  "id_usuario" integer,
  "tipo" tipo_documento,
  "numero" varchar NOT NULL,
  "emissao" date NOT NULL,
  "validade" date NOT NULL,
  FOREIGN KEY ("id_usuario") REFERENCES "usuario" ("id_usuario")
);

CREATE TABLE "setor" (
  "id_setor" serial PRIMARY KEY,
  "matricula" integer,
  "nome_setor" varchar NOT NULL,
  "responsavel" varchar NOT NULL,
  "id_empresa" integer,
  FOREIGN KEY ("id_empresa") REFERENCES "empresa" ("id_empresa"),
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "contra_cheque" (
  "id_contra_cheque" serial PRIMARY KEY,
  "matricula" integer,
  "bonus" float,
  "pessoa" tipo_pessoa NOT NULL,
  "desconto" float,
  "razao_desconto" varchar,
  "data_pagamento" date NOT NULL,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "registro_horas" (
  "id_registro" serial PRIMARY KEY,
  "matricula" integer,
  "data" date NOT NULL,
  "hora_entrada" time NOT NULL,
  "hora_saida" time NOT NULL,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

CREATE TABLE "avaliacao" (
  "id_avaliacao" serial PRIMARY KEY,
  "matricula" integer,
  "avaliador" varchar NOT NULL,
  "data_avaliacao" date NOT NULL,
  "nota" integer NOT NULL,
  "competencia" varchar NOT NULL,
  "comentarios" varchar,
  FOREIGN KEY ("matricula") REFERENCES "funcionario" ("matricula")
);

