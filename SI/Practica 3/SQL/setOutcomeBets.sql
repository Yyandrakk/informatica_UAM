UPDATE 
  clientbets
SET 
  outcome = (CASE WHEN clientbets.optionid = temporal.winneropt THEN (clientbets.bet * clientbets.ratio) ELSE 0 END)
FROM 
  (SELECT betid,winneropt FROM bets WHERE winneropt IS NOT NULL) AS temporal 
WHERE 
  clientbets.betid = temporal.betid;
