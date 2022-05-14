IF EXISTS (SELECT name FROM sys.databases WHERE name = 'A3') BEGIN EXEC ('USE A3') END
ELSE BEGIN CREATE DATABASE A3 END

-- Setting up Logging system:

CREATE TABLE LogConcurrencyIssues (
	currentTime DATETIME,
	info VARCHAR(100),
	resource_type VARCHAR(100),
	request_mode  VARCHAR(100), 
	request_type  VARCHAR(100), 
	request_status  VARCHAR(100),
	request_session_id INT 
)


CREATE TABLE LogConcurrencyIssuesTemp (
	currentTime DATETIME,
	info VARCHAR(100),
	resource_type VARCHAR(100),
	request_mode  VARCHAR(100), 
	request_type  VARCHAR(100), 
	request_status  VARCHAR(100),
	request_session_id INT 
)

GO
CREATE OR ALTER PROCEDURE addLogConcurrencyIssue(@info VARCHAR(100)) AS
	INSERT INTO LogConcurrencyIssues 
	SELECT GETDATE(), @info, resource_type, request_mode, request_type, request_status, request_session_id 
	FROM sys.dm_tran_locks
	WHERE request_owner_type='TRANSACTION'
GO

CREATE OR ALTER PROCEDURE addLogConcurrencyIssueTemp(@info VARCHAR(100)) AS
	INSERT INTO LogConcurrencyIssuesTemp
	SELECT GETDATE(), @info, resource_type, request_mode, request_type, request_status, request_session_id 
	FROM sys.dm_tran_locks
	WHERE request_owner_type='TRANSACTION'
GO


CREATE OR ALTER PROCEDURE ClearLogs AS
	DROP TABLE LogConcurrencyIssues
	CREATE TABLE LogConcurrencyIssues (
	currentTime DATETIME,
	info VARCHAR(100),
	resource_type VARCHAR(100),
	request_mode  VARCHAR(100), 
	request_type  VARCHAR(100), 
	request_status  VARCHAR(100),
	request_session_id INT )
GO


-- Creating tables:

create table Client (
	id int primary key identity(1,1),
	fname varchar(100),
	lname varchar(100)
)

create table Imobil(
	id int primary key identity(1,1),
	addr varchar(100),
	pret INT
)

create table Vizita(
	cid int references Client(id),
	iid int references Imobil(id),
	primary key(cid, iid)
)
go

--Grade 3:

create or alter procedure usp_insertDataClient(@fname varchar(100), @lname varchar(100)) AS
begin
		if (@fname = '' OR @lname = '') 
			raiserror('Erro', 14, 1)
		insert into Client(fname, lname) values (@fname, @lname)
end
go

create or alter procedure usp_insertDataImobil(@pret INT, @addr varchar(100)) AS
begin
		if (@pret <= 0 OR @addr = '') 
			raiserror('Erro', 14, 1)
		insert into Imobil(addr, pret) values (@addr, @pret)
end
go

create or alter procedure usp_insertDataVizita(@fname varchar(100), @lname varchar(100), @addr varchar(100), @pret INT) AS
begin
	DECLARE @clientID INT
	SET @clientID = (SELECT C.id FROM Client C WHERE C.fname = @fname AND C.lname = @lname)
	DECLARE @imobilID INT
	SET @imobilID = (SELECT I.id FROM Imobil I WHERE I.addr = @addr AND I.pret = @pret)
	IF (@clientID = null)
	BEGIN
		RAISERROR('Client does not exist', 16, 1);
	END
	IF (@imobilID = null)
	BEGIN
		RAISERROR('Imobil does not exist', 16, 1);
	END
	INSERT INTO Vizita(cid, iid) VALUES (@clientID, @imobilID)
end
go

create or alter procedure usp_insertDataVizitaRollback AS
	begin tran
	begin try
		
		EXEC usp_insertDataClient 'Andrei', 'Mihai'
		EXEC usp_insertDataImobil 260, 'addr1'
		EXEC usp_insertDataVizita 'Andrei', 'Mihai','addr1', 260

		commit tran
		select 'T commited'
	end try
	begin catch
		rollback tran
		select 'T rollbacked'
	end catch
go

Delete from imobil
Delete from client
Delete from vizita

EXEC usp_insertDataVizitaRollback 

Select * from Client
Select * from Imobil
Select * from Vizita


--- 1. Dirty reads
--- SET transaction isolation level read uncommitted
--- T1: begin T1, update, delay (WAITFOR DELAY '00:00:03'), rollback
--- T2: begin T2, select, delay, select, commit
--- SOLUTION: read committed
--- T1 :

DECLARE @tempTable TABLE (
	currentTime DATETIME,
	info VARCHAR(100),
	resource_type VARCHAR(100),
	request_mode  VARCHAR(100), 
	request_type  VARCHAR(100), 
	request_status  VARCHAR(100),
	request_session_id INT 
)

BEGIN TRAN
INSERT INTO @tempTable(currentTime, info, resource_type, request_mode, request_type, request_status, request_session_id)
SELECT GETDATE(), 'dirty read - before update', resource_type, request_mode, request_type, request_status, request_session_id 
FROM sys.dm_tran_locks
WHERE request_owner_type='TRANSACTION'

UPDATE Client SET fname = 'Dirty' WHERE fname = 'Andrei' 

INSERT INTO @tempTable
SELECT GETDATE(), 'dirty read - after update', resource_type, request_mode, request_type, request_status, request_session_id 
FROM sys.dm_tran_locks
WHERE request_owner_type='TRANSACTION'

WAITFOR DELAY '00:00:03:000'

ROLLBACK TRAN

SELECT * FROM @tempTable
INSERT INTO LogConcurrencyIssues
SELECT * FROM @tempTable

SELECT * FROM LogConcurrencyIssues

--- T2:
-- SOLUTION
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
BEGIN TRAN

EXEC addLogConcurrencyIssue 'dirty read - before select'

SELECT * FROM Client

EXEC addLogConcurrencyIssue 'dirty read - after select'

COMMIT TRAN

SELECT * FROM LogConcurrencyIssues


--- 2. NON-REPEATABLE READS
--- SET transaction isolation level read committed
--- T1: insert, begin T1, delay (WAITFOR DELAY '00:00:03'), update, commit
--- T2: begin T2, select, delay, select, commit
--- SOLUTION: repeatable read 

--- T1:

EXEC usp_insertDataClient 'Andrei', 'Rus'

BEGIN TRAN
	EXEC addLogConcurrencyIssue 'non-repeatable read - before update'

	UPDATE Client 
	SET fname = 'Dirty'
	WHERE fname = 'Andrei'
	
	EXEC addLogConcurrencyIssue 'non-repeatable read - after update'

COMMIT TRAN

DELETE FROM Client WHERE fname='Dirty'

SELECT * FROM LogConcurrencyIssues

SELECT @@TRANCOUNT

--- T2:

SET TRANSACTION ISOLATION LEVEL READ COMMITTED 

-- SOLUTION
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
	
	EXEC addLogConcurrencyIssue 'non-repeatable read - before select'

	SELECT * FROM Client

	EXEC addLogConcurrencyIssue 'non-repeatable read - between select'

	WAITFOR DELAY '00:00:03:000'

	SELECT * FROM Client

	EXEC addLogConcurrencyIssue 'non-repeatable read - after select'

COMMIT TRAN

SELECT @@TRANCOUNT

--- 3. PHANTOM READS
--- SET transaction isolation level repeatable read 
--- T1: begin T1, delay (WAITFOR DELAY '00:00:03'), update/insert, commit
--- T2: begin T2, select, delay, select, commit
--- SOLUTION: serializable

-- T1:

DELETE FROM Client WHERE ID = 99

BEGIN TRAN
	EXEC addLogConcurrencyIssue 'phantom read - before insert'

	INSERT INTO Client (id, fname, lname) VALUES (99, 'Marcelus', 'Purcelus')

	EXEC addLogConcurrencyIssue 'phantom read - after insert'

COMMIT TRAN

-- T2:

SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN

	EXEC addLogConcurrencyIssue 'phantom read - before select'

	SELECT * FROM Client

	EXEC addLogConcurrencyIssue ' phantom read - between select'

	WAITFOR DELAY '00:00:03:000'

	SELECT * FROM Client

	EXEC addLogConcurrencyIssue 'phantom read - after select'

COMMIT TRAN


--- 4. DEADLOCK
--- T1: begin T1, update on table A, deplay, update on table B, commit
--- T2: begin T2, update on table B, deplay, update on table A, commit

--- SOLUTION: set deadlock priority HIGH, NORMAL, LOW, -10 ..10

-- T1:

EXEC usp_insertDataClient 'prenume1', 'nume1'
EXEC usp_insertDataImobil 69, 'Deadlock addr'
BEGIN TRAN
	EXEC addLogConcurrencyIssue 'deadlock1 - before update'

	UPDATE Client
	SET fname = 'Marian'
	WHERE lname = 'nume1'

	EXEC addLogConcurrencyIssue 'deadlock1 - between updates'

	WAITFOR DELAY '00:00:03:000'

	UPDATE Imobil
	SET addr = 'Marian'
	WHERE pret = 69

	EXEC addLogConcurrencyIssue 'deadlock1 - after updates'
COMMIT TRAN

SELECT * FROM Client
SELECT * FROM Imobil

-- T2:

BEGIN TRAN
	EXEC addLogConcurrencyIssue 'deadlock1 - before update'

	UPDATE Imobil
	SET addr = 'Marian'
	WHERE pret = 69

	EXEC addLogConcurrencyIssue 'deadlock1 - between updates'

	WAITFOR DELAY '00:00:03:000'

	UPDATE Client
	SET fname = 'Marian'
	WHERE lname = 'nume1'

	EXEC addLogConcurrencyIssue 'deadlock1 - after updates'
COMMIT TRAN

-- sweet 7 :p
