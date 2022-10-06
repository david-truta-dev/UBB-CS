create database LibrarySystem;



CREATE TABLE Author(
	id INT PRIMARY KEY,
	authName VARCHAR(100) NOT NULL,
	birthDate DATE,
);

CREATE TABLE Section(
	id INT PRIMARY KEY,
	sectName VARCHAR(100) NOT NULL,
	floorNr INT
);

CREATE TABLE Book(
	id INT PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	decription VARCHAR(100) NOT NULL,
	sectionId INT FOREIGN KEY REFERENCES Section(id) ON DELETE SET NULL,
);

CREATE TABLE Writes(
	id INT PRIMARY KEY,
	authId INT,
	FOREIGN KEY (authId) REFERENCES Author(id) ON DELETE CASCADE,
	bookId INT,
	FOREIGN KEY (bookId) REFERENCES Book(id) ON DELETE CASCADE,
);

CREATE TABLE LibraryUser(
	id INT PRIMARY KEY,
	fname VARCHAR(100) NOT NULL,
	lname VARCHAR(100) NOT NULL,
	permit INT UNIQUE,
);

CREATE TABLE Borrows(
	id INT PRIMARY KEY,
	libraryUserId INT,
	FOREIGN KEY (libraryUserId) REFERENCES LibraryUser(id) ON DELETE CASCADE,
	bookId INT,
	FOREIGN KEY (bookId) REFERENCES Book(id) ON DELETE CASCADE,
	borrowDate DATE,
	borrowTime TIME
);

DROP TABLE Borrows;

Select * from Section;
Select * from Book;

insert into Section(id, sectName, floorNr) VALUES (1, 'sect1', 1);
insert into Section(id, sectName, floorNr) VALUES (2, 'sect2', 2);