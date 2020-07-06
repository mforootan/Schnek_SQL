
-- Transactions commit even with errors... 
-- That's why we turn XACT_ABORT ON...

CREATE TABLE dbo.WhateverFor
(ID int NOT NULL PRIMARY KEY);

BEGIN TRAN
	INSERT INTO dbo.WhateverFor VALUES(1);
	INSERT INTO dbo.WhateverFor VALUES(1);
	INSERT INTO dbo.WhateverFor VALUES(2);
COMMIT TRAN

SELECT * FROM dbo.WhateverFor;

TRUNCATE TABLE dbo.WhateverFor;

SELECT * FROM dbo.WhateverFor;

SET XACT_ABORT ON;

BEGIN TRAN
	INSERT INTO dbo.WhateverFor VALUES(1);
	INSERT INTO dbo.WhateverFor VALUES(1);
	INSERT INTO dbo.WhateverFor VALUES(2);
COMMIT TRAN

SET XACT_ABORT OFF;

SELECT * FROM dbo.WhateverFor;
