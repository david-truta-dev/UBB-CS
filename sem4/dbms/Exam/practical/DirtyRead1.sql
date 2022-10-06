USE LibrarySystem;

--- 1. Dirty reads
--- SET transaction isolation level read uncommitted
--- T1: begin T1, update, delay (WAITFOR DELAY '00:00:05'), rollback
--- T2: begin T2, select, delay, select, commit
--- SOLUTION: read committed

--- T1 :

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN

UPDATE LibraryUser SET fname = 'nume';
WAITFOR DELAY '00:00:05:000'

ROLLBACK TRAN

--- T2:

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN

SELECT * FROM LibraryUser;
WAITFOR DELAY '00:00:10:000'
SELECT * FROM LibraryUser;


COMMIT TRAN
