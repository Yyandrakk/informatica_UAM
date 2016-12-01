explain select count(*) 
from clientbets
where outcome is null;

explain select count(*) 
from clientbets 
where outcome =0;

DROP INDEX IF EXISTS idx_outcome_clientbets ;
CREATE INDEX idx_outcome_clientbets ON clientbets(outcome);

explain select count(*) 
from clientbets
where outcome is null;

explain select count(*) 
from clientbets 
where outcome =0;

VACUUM VERBOSE ANALYZE  clientbets;

explain select count(*) 
from clientbets
where outcome is null;

explain select count(*) 
from clientbets 
where outcome =0;

explain select count(*) 
from clientbets 
where outcome > 0;

explain select count(*) 
from clientbets 
where outcome > 200;