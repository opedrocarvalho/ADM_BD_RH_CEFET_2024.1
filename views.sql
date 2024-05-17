CREATE VIEW informacao_funcionarios AS 
SELECT
  matricula serial
  data_admissao date
  data_demissao date
  motivo_demissao varchar
  id_empresa integer 
  id_cargo integer 
  id_usuario integer  

FROM funcionarios

INNER JOIN empresa on (empresa.id_empresa = funcionario.id_empresa)
INNER JOIN cargo on (cargo.id_cargo = funcionario.id_cargo )
INNER JOIN usuario on (usuario.id_ususario = funcionario.id_usuario);
------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE VIEW informacao_usuario AS
SELECT
  id_usuario serial 
  responsavel varchar 
  nome_completo varchar
  telefone varchar 
  email varchar  
  naturalidade varchar
  genero genero
  data_nascimento date 
  id_endereco integer

FROM usuario 

INNER JOIN endereco on (endereco.id_endereco = usuario.id_endereco);

------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW informacao_contra_cheque AS
SELECT

  id_contra_cheque serial
  matricula integer
  bonus float
  pessoa tipo_pessoa 
  desconto float 
  razao_desconto varchar
  data_pagamento date 

FROM contra_cheque

------------------------------------------------------------------------------------------------------------------------------------------------------------

CREATE VIEW informacao_ferias AS
SELECT 
  
  id_ferias serial 
  matricula integer 
  data_entrada date
  data_retorno date

FROM ferias
