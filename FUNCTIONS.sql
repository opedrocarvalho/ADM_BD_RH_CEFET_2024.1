--- 1) Função para calcular o bônus:
--- Usei o critério que se o funcionário tirar nota maior ou igual a 8 em mais de 3 competências avaliadas, ele receberá um bÔnus de 10% do seu salário

CREATE OR REPLACE FUNCTION calcular_bonus(matricula_func int)
RETURNS float AS $$
DECLARE
  salario_base float;
  competencias_acima_ou_igual_8 int;
  bonus float;
BEGIN
  SELECT c.salario INTO salario_base 
  FROM cargo c
  JOIN funcionario f ON c.id_cargo = f.id_cargo
  WHERE f.matricula = matricula_func;

  SELECT COUNT(*) INTO competencias_acima_ou_igual_8 
  FROM avaliacao
  WHERE matricula = matricula_func AND nota >= 8;

  IF competencias_acima_ou_igual_8 > 3 THEN
    bonus := salario_base * 0.10;  
  ELSE
    bonus := 0;
  END IF;

  RETURN bonus;
END;
$$ LANGUAGE plpgsql;


--- 2) Função para calcular o salário total do funcionário:

CREATE OR REPLACE FUNCTION calcular_salario_total(matricula_func int)
RETURNS float AS $$
DECLARE
  salario_base float;
  bonus_total float;
  descontos_total float;
  salario_total float;
BEGIN
  SELECT c.salario INTO salario_base 
  FROM cargo c
  JOIN funcionario f ON c.id_cargo = f.id_cargo
  WHERE f.matricula = matricula_func;

  SELECT COALESCE(SUM(bonus), 0) INTO bonus_total 
  FROM contra_cheque
  WHERE matricula = matricula_func;

  SELECT COALESCE(SUM(desconto), 0) INTO descontos_total 
  FROM contra_cheque
  WHERE matricula = matricula_func;

  salario_total := salario_base + bonus_total - descontos_total;
  RETURN salario_total;
END;
$$ LANGUAGE plpgsql;


--- 3) Função para calcular o tempo de serviço de um funcionário na empresa:

CREATE OR REPLACE FUNCTION calcular_tempo_servico(matricula_func int)
RETURNS integer AS $$
DECLARE
  data_admissao date;
  data_demissao date;
  anos_servico integer;
BEGIN
  SELECT data_admissao, data_demissao INTO data_admissao, data_demissao 
  FROM funcionario
  WHERE matricula = matricula_func;

  IF data_demissao IS NULL THEN
    anos_servico := EXTRACT(year FROM AGE(CURRENT_DATE, data_admissao));
  ELSE
    anos_servico := EXTRACT(year FROM AGE(data_demissao, data_admissao));
  END IF;

  RETURN anos_servico;
END;
$$ LANGUAGE plpgsql;


--- 4) Função para calcular hora extra de um funcionário:

CREATE OR REPLACE FUNCTION calcular_horas_extras(matricula_func int)
RETURNS float AS $$
DECLARE
  horas_extras_total float;
  horas_trabalhadas float;
  horas_entrada time;
  horas_saida time;
  data_reg date;
BEGIN
  horas_extras_total := 0;

  FOR horas_entrada, horas_saida, data_reg IN
    SELECT hora_entrada, hora_saida, data 
    FROM registro_horas
    WHERE matricula = matricula_func
  LOOP
    horas_trabalhadas := EXTRACT(epoch FROM (horas_saida - horas_entrada)) / 3600;
    IF horas_trabalhadas > 8 THEN
      horas_extras_total := horas_extras_total + (horas_trabalhadas - 8);
    END IF;
  END LOOP;

  RETURN horas_extras_total;
END;
$$ LANGUAGE plpgsql;
