IF DB_ID('lab05') IS NOT NULL
	USE lab05;
ELSE 
	CREATE DATABASE lab05;


CREATE TABLE Ta(
	aid INT PRIMARY KEY, 
	a2 INT UNIQUE,
	a3 INT,
	a4 INT
);

CREATE TABLE Tb(
	bid INT PRIMARY KEY, 
	b2 INT
);

CREATE TABLE Tc(
	cid INT PRIMARY KEY, 
	aid INT FOREIGN KEY REFERENCES Ta(aid),
	bid INT FOREIGN KEY REFERENCES Tb(bid)
);

--  ///////////////    a    ////////////////

DECLARE @i INT
SET @i = 0
WHILE (@i < 5000)
BEGIN
	IF (@i % 2 =0)
		INSERT INTO Ta(aid, a2, a3, a4) VALUES (@i, @i+1, @i+2, @i+2);
	ELSE 
		INSERT INTO Ta(aid, a2, a3, a4) VALUES (@i, @i+1, @i+1, @i+4);
	SET @i = @i +1
END

DELETE FROM Ta;
Select * from Ta;

-- clustered index scan:
SELECT * FROM Ta WHERE a3=432;

-- clustered index seek:
SELECT * FROM Ta WHERE aid=240;

-- non-clustered index scan:
CREATE NONCLUSTERED INDEX IX_a4 ON Ta(a4);
SELECT a4 FROM Ta;

-- non-clustered index seek AND key lookup:
SELECT * FROM Ta WHERE a2=356;

-- ///////////   b   //////////////

DECLARE @i INT
SET @i = 0
WHILE (@i < 20000)
BEGIN
	IF (@i % 2 =0)
		INSERT INTO Tb(bid, b2) VALUES (@i, @i+1);
	ELSE 
		INSERT INTO Tb(bid, b2) VALUES (@i, @i+2);
	SET @i = @i +1
END

DELETE FROM Tb;
SELECT * FROM Tb;

DROP INDEX Tb.IX_b2;
SELECT b2 FROM Tb WHERE b2=123;

CREATE NONCLUSTERED INDEX IX_b2 ON Tb(b2);
SELECT b2 FROM Tb WHERE b2=123;


-- ///////////   c   //////////////
DECLARE @i INT
SET @i = 0
WHILE (@i < 5000)
BEGIN
	INSERT INTO Tc(cid, bid, aid) VALUES (@i, @i, @i);
	SET @i = @i +1
END

DELETE FROM Tc;
SELECT * FROM Tc;

GO
DROP VIEW IF EXISTS my_view;
GO
CREATE VIEW my_view AS
	SELECT Ta.aid, Tc.cid FROM
	Ta JOIN Tc ON Tc.aid = Ta.aid
	WHERE Ta.a2 > 3000
GO

DROP INDEX IF EXISTS IX_Tc_aid ON Tc;
CREATE NONCLUSTERED INDEX IX_Tc_aid ON Tc(aid);

SELECT * FROM my_view;

GO