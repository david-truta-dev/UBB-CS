
-- INCHIRIERI IMOBILIARE

CREATE DATABASE inchirieri
-- Tables:

CREATE TABLE agentie(
	id INT PRIMARY KEY,
	nume VARCHAR(100) NOT NULL,
	numar_agenti INT NOT NULL
);

CREATE TABLE client(
	id INT PRIMARY KEY,
	prenume VARCHAR(100) NOT NULL,
	nume VARCHAR(100) NOT NULL,
);

CREATE TABLE agent(
	id INT PRIMARY KEY,
	prenume VARCHAR(100) NOT NULL,
	nume VARCHAR(100) NOT NULL,
	-- 1:m : agent -> lucreaza - agentie;
	agentie_id INT FOREIGN KEY REFERENCES agentie(id) ON DELETE SET NULL
);

CREATE TABLE proprietar(
	id INT PRIMARY KEY,
	prenume VARCHAR(100) NOT NULL,
	nume VARCHAR(100) NOT NULL,
	-- 1:m proprietar -> promovare imobil - agentie;
	agentie_id INT FOREIGN KEY REFERENCES agentie(id) ON DELETE SET NULL
);

CREATE TABLE locatie(
	id INT PRIMARY KEY,
	oras VARCHAR(60),
	zona VARCHAR(60)
);

CREATE TABLE imobil(
	id INT PRIMARY KEY,
	pret INT NOT NULL,
	-- 1:m : imbobil -> inchiriere - client;
	client_id INT FOREIGN KEY REFERENCES client(id) ON DELETE SET NULL,
	-- 1:m : imbobil -> are - proprietar;
	proprietar_id INT NOT NULL FOREIGN KEY REFERENCES proprietar(id) ON DELETE CASCADE,
	-- 1:m : imbobil -> are - locatie;
	locatie_id INT NOT NULL FOREIGN KEY REFERENCES locatie(id) ON DELETE CASCADE
);

CREATE TABLE apartament(
	id INT PRIMARY KEY,
	imobil_id INT FOREIGN KEY REFERENCES imobil(id) ON DELETE CASCADE
);

CREATE TABLE garsoniera(
	id INT PRIMARY KEY,
	imobil_id INT FOREIGN KEY REFERENCES imobil(id) ON DELETE CASCADE
);

CREATE TABLE vila(
	id INT PRIMARY KEY,
	imobil_id INT FOREIGN KEY REFERENCES imobil(id) ON DELETE CASCADE
);

-- n:m : client - vizita - imobil:

CREATE TABLE vizita(
	id INT PRIMARY KEY,
	id_client INT,
	FOREIGN KEY (id_client) REFERENCES client(id) ON DELETE CASCADE,
	id_imobil INT,
	FOREIGN KEY (id_imobil) REFERENCES imobil(id) ON DELETE CASCADE,
	data_vizita DATE 
);


-- Some entities:


INSERT INTO agentie(id, nume, numar_agenti) VALUES (1, 'Blitz', 1);
INSERT INTO agentie(id, nume, numar_agenti) VALUES (2, 'Art Real Estate', 1);
INSERT INTO agentie(id, nume, numar_agenti) VALUES (3, 'Napoca Imobiliare', 1);
INSERT INTO client(id, nume, prenume) VALUES (1, 'Truta', 'David');
INSERT INTO client(id, nume, prenume) VALUES (2, 'Antonescu', 'Theodor');
INSERT INTO client(id, nume, prenume) VALUES (3, 'Petrica', 'Virgiliu');
INSERT INTO agent(id, nume, prenume, agentie_id) VALUES (1, 'Gheorghe', 'Marcela', 1);
INSERT INTO agent(id, nume, prenume, agentie_id) VALUES (2, 'Sala', 'Martin', 2);
INSERT INTO agent(id, nume, prenume, agentie_id) VALUES (3, 'Serban', 'Andreea', 3);
INSERT INTO proprietar(id, nume, prenume) VALUES (1, 'Ardelean', 'David');
INSERT INTO proprietar(id, nume, prenume, agentie_id) VALUES (2, 'Florentin', 'Daniel', 2);
INSERT INTO proprietar(id, nume, prenume, agentie_id) VALUES (3, 'Radu', 'Veronica', 1);
INSERT INTO locatie(id, oras, zona) VALUES (1, 'Cluj-Napoca', 'Intre Lacuri');
INSERT INTO locatie(id, oras, zona) VALUES (2, 'Cluj-Napoca', 'Marasti');
INSERT INTO locatie(id, oras, zona) VALUES (3, 'Cluj-Napoca', 'Gheorgheni');
INSERT INTO imobil(id, pret, client_id, proprietar_id, locatie_id) VALUES (1, 220, 1, 1, 1);
INSERT INTO imobil(id, pret, client_id, proprietar_id, locatie_id) VALUES (2, 370, NULL, 2, 2);
INSERT INTO imobil(id, pret, client_id, proprietar_id, locatie_id) VALUES (3, 450, 3, 3, 2);
INSERT INTO vizita(id, id_client, id_imobil, data_vizita) VALUES (1, 1, 2, '2021-04-20');
INSERT INTO vizita(id, id_client, id_imobil, data_vizita) VALUES (2, 1, 1, '2021-04-21');
INSERT INTO vizita(id, id_client, id_imobil, data_vizita) VALUES (3, 3, 3, '2021-04-22');
INSERT INTO apartament(id, imobil_id) VALUES (1, 1);
INSERT INTO garsoniera(id, imobil_id) VALUES (1, 2);
INSERT INTO vila(id, imobil_id) VALUES (1, 3);


-- Show tables:


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


