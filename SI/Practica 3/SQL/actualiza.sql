ALTER TABLE customers DROP COLUMN address1 RESTRICT;

ALTER TABLE customers DROP COLUMN address2 RESTRICT;

ALTER TABLE customers DROP COLUMN city RESTRICT;

ALTER TABLE customers DROP COLUMN zip RESTRICT;

ALTER TABLE customers DROP COLUMN state RESTRICT;

ALTER TABLE customers DROP COLUMN country RESTRICT;

ALTER TABLE customers DROP COLUMN region RESTRICT;

ALTER TABLE customers DROP COLUMN phone RESTRICT;

ALTER TABLE customers DROP COLUMN creditcardtype RESTRICT;

ALTER TABLE customers DROP COLUMN age RESTRICT;

ALTER TABLE customers DROP COLUMN gender RESTRICT;

ALTER TABLE options DROP COLUMN categoria RESTRICT;

ALTER TABLE clientbets DROP COLUMN customerid RESTRICT;

ALTER TABLE optionbet DROP COLUMN optiondesc RESTRICT;

ALTER TABLE clientorders ADD COLUMN totaloutcome integer;

ALTER TABLE customers ALTER COLUMN email SET NOT NULL;

ALTER TABLE customers ADD CONSTRAINT email_unico UNIQUE(email);

CREATE INDEX idx_email_customers ON customers(email);

CREATE INDEX idx_orderid_clientorders ON clientorders(orderid);

SELECT setval('clientorders_id_seq', COALESCE((SELECT MAX(orderid)+1 FROM clientorders), 1), false);


