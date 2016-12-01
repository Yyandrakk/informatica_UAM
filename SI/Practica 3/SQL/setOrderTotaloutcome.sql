CREATE OR REPLACE FUNCTION finalRes (integer)
RETURNS VOID AS $$
DECLARE
id ALIAS FOR $1;
BEGIN
IF(id = -1) THEN
    UPDATE clientorders SET totaloutcome = res.suma FROM  (SELECT orderid, SUM(outcome) AS suma FROM clientbets GROUP BY orderid) AS res WHERE clientorders.orderid=res.orderid;
ELSE
   UPDATE clientorders SET totaloutcome = (SELECT SUM(outcome) FROM clientbets WHERE orderid=id GROUP BY orderid ) WHERE clientorders.orderid=id;
END IF;
END;
$$ LANGUAGE plpgsql;

SELECT finalRes(-1);