CREATE OR REPLACE FUNCTION atualiza_data_demissao()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE funcionario
    SET data_demissao = CURRENT_DATE
    WHERE matricula = OLD.matricula;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_atualiza_data_demissao
BEFORE DELETE ON funcionario
FOR EACH ROW
EXECUTE FUNCTION atualiza_data_demissao();

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION verifica_funcionario_existe()
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM funcionario WHERE matricula = NEW.matricula) THEN
        RAISE EXCEPTION 'Funcionário com matrícula % não existe', NEW.matricula;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verifica_funcionario_existe
BEFORE INSERT ON registro_horas
FOR EACH ROW
EXECUTE FUNCTION verifica_funcionario_existe();

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------CREATE OR REPLACE FUNCTION verifica_valor_beneficio()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.valor < 0 THEN
        RAISE EXCEPTION 'O valor do benefício não pode ser negativo';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verifica_valor_beneficio
BEFORE INSERT OR UPDATE ON beneficio
FOR EACH ROW
EXECUTE FUNCTION verifica_valor_beneficio();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------