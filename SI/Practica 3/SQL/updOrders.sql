CREATE OR REPLACE FUNCTION updOrders() RETURNS trigger AS $$
BEGIN 
 IF (TG_OP = 'DELETE' ) THEN

	/* UPDATE clientorders SET totalamount = temporal.suma FROM (SELECT orderid,SUM(bet) AS suma FROM clientbets GROUP BY orderid) AS temporal WHERE clientorders.orderid = OLD.orderid AND OLD.orderid = temporal.orderid;
*/
	 UPDATE clientorders SET totalamount = (SELECT SUM(bet) FROM clientbets WHERE orderid= OLD.orderid  GROUP BY orderid)WHERE clientorders.orderid = OLD.orderid;

	 EXECUTE finalRes(OLD.orderid); 

	 RETURN NULL;
 ELSE

	UPDATE clientorders SET totalamount = (SELECT SUM(bet) FROM clientbets WHERE orderid= NEW.orderid  GROUP BY orderid)WHERE clientorders.orderid = NEW.orderid;
	 EXECUTE finalRes(NEW.orderid); 
	 RETURN NEW;
 END IF;

END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS actualizaClientOrders on clientbets;

CREATE TRIGGER actualizaClientOrders 
  AFTER INSERT OR UPDATE OR DELETE
  ON clientbets
  FOR EACH ROW
  EXECUTE PROCEDURE updOrders();