CREATE OR REPLACE FUNCTION finalResTrigger() RETURNS trigger AS $$
BEGIN 
IF (NEW.winneropt!=OLD.winneropt) THEN
 UPDATE CLIENTBETS SET outcome=
CASE WHEN clientbets.optionid = NEW.winneropt THEN clientbets.bet*clientbets.ratio
     
     ELSE 0 
END WHERE NEW.betid = clientbets.betid;
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS actualizaInfo on bets;
CREATE TRIGGER actualizaInfo
  AFTER INSERT OR UPDATE OF winneropt
  ON bets
  FOR EACH ROW
  EXECUTE PROCEDURE finalResTrigger();

