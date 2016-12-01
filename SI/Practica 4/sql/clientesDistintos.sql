DROP INDEX IF EXISTS idx_totalamount_clientorders;
CREATE INDEX idx_totalamount_clientorders ON clientorders(totalamount);

SELECT DISTINCT 
  COUNT(customerid) 
FROM customers 
WHERE customerid IN(SELECT 
                           customerid 
                    FROM clientorders 
                    WHERE DATE_PART('month', date)='3' AND DATE_PART('year',date)='2013' AND totalamount>100);