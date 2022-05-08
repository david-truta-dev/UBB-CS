USE inchirieri
GO

--a modify the type of a column
CREATE PROCEDURE doA
AS 
	ALTER TABLE proprietar
	ALTER COLUMN nume VARCHAR(50)
GO



--a revert modification
CREATE PROCEDURE undoA
AS 
	ALTER TABLE proprietar
	ALTER COLUMN nume VARCHAR(100)
GO

--b add a column;
CREATE PROCEDURE doB
AS
	ALTER TABLE proprietar
	ADD nrProprietati INT
GO

--b remove a column;
CREATE PROCEDURE undoB
AS
	ALTER TABLE proprietar
	DROP COLUMN nrProprietati
GO

--c add a DEFAULT constraint;
CREATE PROCEDURE doC
AS
	ALTER TABLE client
	ADD CONSTRAINT dfName DEFAULT 'none given' FOR nume;
GO

--c remove a DEFAULT constraint;
CREATE PROCEDURE undoC
AS
	ALTER TABLE client
	DROP CONSTRAINT dfName;
GO

--d add a primary key
CREATE PROCEDURE doD
AS
	ALTER TABLE agent
	DROP CONSTRAINT PK__agent__3213E83F87118257
	ALTER TABLE agent
	ADD CONSTRAINT PK_agent PRIMARY KEY(id, nume);
GO

--d remove a primary key
CREATE PROCEDURE undoD
AS
	ALTER TABLE agent
	DROP CONSTRAINT PK_agent
	ALTER TABLE agent
	ADD CONSTRAINT PK__agent__3213E83F87118257 PRIMARY KEY(id);
GO

--e add a candidate key
CREATE PROCEDURE doE
AS
	ALTER TABLE client
	ADD CONSTRAINT CK_client_1 UNIQUE(id,nume, prenume);
GO

--e remove a candidate key
CREATE PROCEDURE undoE
AS
	ALTER TABLE client
	DROP CONSTRAINT CK_client_1;
GO

--f add a foreign key
CREATE PROCEDURE doF
AS
	ALTER TABLE imobil
	ADD agentie_imobil_id INT
	ALTER TABLE imobil
	ADD CONSTRAINT FK_agentie FOREIGN KEY (agentie_imobil_id) REFERENCES agentie(id);
GO

--f remove a candidate key
CREATE PROCEDURE undoF
AS
	ALTER TABLE imobil
	DROP FK_agentie;
	ALTER TABLE imobil
	DROP COLUMN agentie_imobil_id;

GO

--g create a table
CREATE PROCEDURE doG
AS
	CREATE TABLE penthouse(
		id int PRIMARY KEY,
		imobil_id INT FOREIGN KEY REFERENCES imobil(id) ON DELETE CASCADE
	);
GO

--g drop the table
CREATE PROCEDURE undoG
AS
	DROP TABLE penthouse;
GO


CREATE TABLE v(
 versiune_curenta INT PRIMARY KEY
);

GO
INSERT INTO v(versiune_curenta) VALUES (1);
GO

CREATE PROCEDURE changeVersion(@v INT)
AS
	IF @v != (SELECT versiune_curenta FROM v) AND @v = 1
	BEGIN
		EXEC undoA;
		EXEC undoB;
		EXEC undoC;
		EXEC undoD;
		EXEC undoE;
		EXEC undoF;
		EXEC undoG;
		DELETE FROM v WHERE versiune_curenta = 2;
		INSERT INTO v(versiune_curenta) VALUES (1);
	END
	ELSE IF @v != (SELECT versiune_curenta FROM v) AND @v = 2 BEGIN
		EXEC doA;
		EXEC doB;
		EXEC doC;
		EXEC doD;
		EXEC doE;
		EXEC doF;
		EXEC doG;
		DELETE FROM v WHERE versiune_curenta = 1;
		INSERT INTO v(versiune_curenta) VALUES (2);
	END
	ELSE IF @v = (SELECT versiune_curenta FROM v) PRINT 'THE DATABASE IS ALREADY SET TO THIS VERSION !'
	ELSE PRINT 'THE ONLY AVAILABLE VERSIONS ARE 1 OR 2 !'
	
GO

EXEC changeVersion 2;

	SELECT * FROM v;

	SELECT * FROM client;
	SELECT * FROM imobil;
	SELECT * FROM vizita;
		
	SELECT * FROM proprietar;	
	SELECT * FROM agent;	
	SELECT * FROM agentie;
	SELECT * FROM locatie;
	SELECT * FROM vila;
	SELECT * FROM garsoniera;
	SELECT * FROM apartament;

	SELECT * FROM penthouse;
