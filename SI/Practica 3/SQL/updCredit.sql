CREATE OR REPLACE FUNCTION updCredit() RETURNS trigger AS $$
BEGIN 

 IF (NEW.date IS NOT NULL AND OLD.date IS NULL) THEN

    UPDATE customers SET credit = credit - NEW.totalamount WHERE customerid = NEW.customerid;
    
    ELSEIF (NEW.date IS NOT NULL AND 0=(SELECT COUNT(winneropt) FROM bets WHERE winneropt IS NULL AND  betid IN (SELECT betid FROM clientbets WHERE orderid=NEW.orderid))) THEN
       UPDATE customers SET credit = credit + NEW.totaloutcome WHERE customerid = NEW.customerid;
    
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS actualizaCreditCustomers on clientorders;
CREATE TRIGGER actualizaCreditCustomers
  AFTER UPDATE 
  ON clientorders
  FOR EACH ROW
  EXECUTE PROCEDURE updCredit();
