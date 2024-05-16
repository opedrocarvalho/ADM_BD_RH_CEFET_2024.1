1)
CREATE OR REPLACE FUNCTION calcular_bonus_trigger()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO contra_cheque (matricula, bonus)
  VALUES (NEW.matricula, calcular_bonus(NEW.matricula));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calcular_bonus_trigger_after_insert
AFTER INSERT ON funcionario
FOR EACH ROW
EXECUTE FUNCTION calcular_bonus_trigger();

2)
CREATE OR REPLACE FUNCTION calcular_salario_total_trigger()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE contra_cheque
  SET salario_total = calcular_salario_total(NEW.matricula)
  WHERE matricula = NEW.matricula;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calcular_salario_total_trigger_after_insert
AFTER INSERT ON funcionario
FOR EACH ROW
EXECUTE FUNCTION calcular_salario_total_trigger();

CREATE TRIGGER calcular_salario_total_trigger_after_update
AFTER UPDATE ON funcionario
FOR EACH ROW
EXECUTE FUNCTION calcular_salario_total_trigger();

3)
CREATE OR REPLACE FUNCTION calcular_tempo_servico_trigger()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE funcionario
  SET tempo_servico = calcular_tempo_servico(NEW.matricula)
  WHERE matricula = NEW.matricula;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calcular_tempo_servico_trigger_after_insert
AFTER INSERT ON funcionario
FOR EACH ROW
EXECUTE FUNCTION calcular_tempo_servico_trigger();

CREATE TRIGGER calcular_tempo_servico_trigger_after_update
AFTER UPDATE ON funcionario
FOR EACH ROW
EXECUTE FUNCTION calcular_tempo_servico_trigger();

4)
CREATE OR REPLACE FUNCTION calcular_horas_extras_trigger()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO registro_horas_extras (matricula, horas_extras)
  VALUES (NEW.matricula, calcular_horas_extras(NEW.matricula));
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER calcular_horas_extras_trigger_after_insert
AFTER INSERT ON registro_horas
FOR EACH ROW
EXECUTE FUNCTION calcular_horas_extras_trigger();
