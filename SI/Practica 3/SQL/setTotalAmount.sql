UPDATE 
  clientorders 
SET 
  totalamount = temporal.suma 
FROM 
  (SELECT orderid,SUM(bet) AS suma FROM clientbets GROUP BY orderid) AS temporal 
WHERE 
  clientorders.orderid = temporal.orderid;

