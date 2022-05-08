-- Creating DB and tables:
CREATE DATABASE db4;
USE db4
GO

CREATE TABLE tbl1 (
	id INT PRIMARY KEY,
	info VARCHAR(100)
);

CREATE TABLE tbl2 (
	id INT PRIMARY KEY,
	id_tbl1 INT FOREIGN KEY REFERENCES tbl1(id),
	info VARCHAR(100)
);

CREATE TABLE tbl3 (
	id1 INT,
	id2 INT,
	CONSTRAINT PK_tbl3 PRIMARY KEY (id1, id2)
);

GO

CREATE VIEW v1 AS
SELECT * FROM tbl1;
GO

CREATE VIEW v2 AS
SELECT tbl2.id, tbl1.info FROM tbl1, tbl2
WHERE tbl1.id = tbl2.id_tbl1;
GO

CREATE VIEW v3 AS
SELECT COUNT(tbl2.id) AS nr_of_tbls, tbl2.id_tbl1
FROM tbl2
GROUP BY tbl2.id_tbl1;
GO

-- ------------------------------------------------------------------------------------

CREATE PROCEDURE insert_in_tbl  @table_name  VARCHAR(50), @nr_rows INT AS
	DECLARE @index int;
	SET @index = 0;

	WHILE @index < @nr_rows BEGIN
		IF @table_name = 'tbl1' BEGIN
			INSERT INTO tbl1 VALUES(@index, 'info1');
		END
		ELSE IF @table_name  = 'tbl2' BEGIN
			INSERT INTO tbl2 VALUES(@index, @index, 'info2');
		END
		ELSE IF @table_name  = 'tbl3' BEGIN
			INSERT INTO tbl3 VALUES(@index, @index + 1);
		END
		SET @index = @index + 1
	END

GO

CREATE PROCEDURE delete_from_tbl @table_name VARCHAR(50) AS
	EXEC('DELETE FROM ' + @table_name + ';');
GO

CREATE PROCEDURE view_test @name VARCHAR(50) AS
	EXEC('SELECT * FROM ' + @name + ';');
GO

CREATE PROCEDURE run @test_id INTEGER AS
	DECLARE @start_time DATETIME;
	DECLARE @end_time DATETIME;

	DECLARE @current_table_name VARCHAR(50);
	DECLARE @current_no_rows INT;
	DECLARE @current_table_id INT;

	DECLARE @test_name VARCHAR(50);
	SET @test_name = (
		SELECT Name
		FROM Tests
		WHERE TestID = @test_id
	);

	SET @start_time = GETDATE();

	IF ( SELECT 1 FROM TestRuns WHERE TestRunID = @test_id)> 0 BEGIN
		UPDATE TestRuns
		SET StartAt = @start_time, EndAt = @end_time WHERE TestRunID = @test_id;
	END
	ELSE BEGIN		
		INSERT INTO TestRuns VALUES(@test_name, @start_time, @end_time);
	END

	-- run tests for delete procedure:
	DECLARE @Cursor CURSOR;
	SET @Cursor = CURSOR FOR
		SELECT [Tables].Name, [TestTables].NoOfRows, [Tables].TableID FROM [TestTables]
		INNER JOIN [Tables] ON [Tables].TableID = [TestTables].TableID
		WHERE TestID = @test_id ORDER BY Position;
	OPEN @Cursor;

	FETCH NEXT FROM @Cursor
	INTO @current_table_name, @current_no_rows, @current_table_id;
	WHILE @@FETCH_STATUS = 0 BEGIN
		EXEC delete_from_tbl @table_name = @current_table_name;
		FETCH NEXT FROM @Cursor INTO @current_table_name, @current_no_rows, @current_table_id;
    END

	CLOSE @Cursor;
    DEALLOCATE @Cursor;


	-- run tests for insert procedure:
	DECLARE @Cursor2 CURSOR;
	SET @Cursor2 = CURSOR FOR
		SELECT [Tables].Name, [TestTables].NoOfRows, [Tables].TableID FROM [TestTables]
		INNER JOIN [Tables] ON [Tables].TableID = [TestTables].TableID
		WHERE TestID = @test_id ORDER BY Position DESC;
	
	OPEN @Cursor2;
	FETCH NEXT FROM @Cursor2
	INTO @current_table_name, @current_no_rows, @current_table_id;
	WHILE @@FETCH_STATUS = 0 BEGIN
		
		SET @start_time = GETDATE();
		EXEC insert_in_tbl @table_name = @current_table_name, @nr_rows = @current_no_rows;
		SET @end_time = GETDATE();

		IF ( SELECT 1 FROM [TestRunTables] WHERE TestRunID = @test_id AND TableID = @current_table_id )> 0 BEGIN
			UPDATE [TestRunTables]
			SET StartAt = @start_time, EndAt = @end_time WHERE TestRunID = @test_id AND TableID = @current_table_id;
		END
		ELSE BEGIN
			INSERT INTO [TestRunTables] VALUES(@test_id, @current_table_id, @start_time, @end_time);
		END

		PRINT @test_id;
		PRINT @current_table_id;
		FETCH NEXT FROM @Cursor2
		INTO @current_table_name, @current_no_rows, @current_table_id;
    END
	CLOSE @Cursor2 ;
    DEALLOCATE @Cursor2;
	

	-- run tests for view procedure:
	DECLARE @Cursor3 CURSOR;
	SET @Cursor3 = CURSOR FOR
		SELECT [Views].Name, [Views].ViewID
		FROM [TestViews]
		INNER JOIN [Views] ON [Views].ViewID = [TestViews].ViewID
		WHERE TestID = @test_id;

	OPEN @Cursor3;
	FETCH NEXT FROM @Cursor3
	INTO @current_table_name, @current_table_id;
	WHILE @@FETCH_STATUS = 0 BEGIN
		
		SET @start_time = GETDATE();
		EXEC view_test @name = @current_table_name;
		SET @end_time = GETDATE();

		IF ( SELECT 1 FROM [TestRunViews] WHERE TestRunID = @test_id AND ViewID = @current_table_id )> 0 BEGIN
			UPDATE [TestRunViews]
			SET StartAt = @start_time, EndAt = @end_time WHERE TestRunID = @test_id AND ViewID = @current_table_id;
		END
		ELSE BEGIN
			INSERT INTO [TestRunViews] VALUES(@test_id, @current_table_id, @start_time, @end_time);
		END

		FETCH NEXT FROM @Cursor3
		INTO @current_table_name, @current_table_id;
    END;
	CLOSE @Cursor3;
    DEALLOCATE @Cursor3;
	
	SET @end_time = GETDATE();
	UPDATE TestRuns
	SET EndAt = @end_time
	WHERE TestRunID = @test_id;

GO


INSERT INTO [Tables] Values ('tbl1');
INSERT INTO [Tables] Values ('tbl2');
INSERT INTO [Tables] Values ('tbl3');

INSERT INTO [Tests] Values('tbl1');
INSERT INTO [Tests] Values('tbl2');
INSERT INTO [Tests] Values('tbl3');

INSERT INTO [Views] VALUES('v1');
INSERT INTO [Views] VALUES('v2');
INSERT INTO [Views] VALUES('v3');


INSERT INTO [TestViews] VALUES(1, 1);
INSERT INTO [TestViews] VALUES(2, 2);
INSERT INTO [TestViews] VALUES(3, 3);

INSERT INTO [TestTables] Values(1, 1, 100, 1);
INSERT INTO [TestTables] Values(2, 2, 30, 2);
INSERT INTO [TestTables] Values(3, 3, 25, 3);

EXEC run @test_id = 1;
EXEC run @test_id = 2;
EXEC run @test_id = 3;

SELECT * FROM Tests;
SELECT * FROM TestRuns;
SELECT * FROM TestTables;
SELECT * FROM TestRunTables;
SELECT * FROM TestRunViews;

SELECT * FROM tbl1;
SELECT * FROM tbl2;
SELECT * FROM tbl3;

DELETE FROM tbl1;
DELETE FROM tbl2;
DELETE FROM tbl3;
