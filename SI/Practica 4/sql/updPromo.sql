ALTER TABLE customers ADD COLUMN promo decimal(5,2);

CREATE OR REPLACE FUNCTION updPromoAmount() RETURNS trigger AS $$
BEGIN
IF NEW.promo != OLD.promo THEN
UPDATE clientorders SET totalamount=(totalamount/((100-OLD.promo)/100))*((100-NEW.promo)/100) WHERE customerid=NEW.customerid;
PERFORM pg_sleep(30);
END IF;
RETURN NEW;
END;
$$ LANGUAGE plpgsql;
DROP TRIGGER IF EXISTS tg_promo on customers;
CREATE TRIGGER tg_promo after UPDATE ON customers
    FOR EACH ROW EXECUTE PROCEDURE updPromoAmount();

BEGIN;
update customers set promo=50 where customerid=14;
commit; 