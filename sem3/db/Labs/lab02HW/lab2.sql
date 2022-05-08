SELECT * FROM apartament;
SELECT * FROM garsoniera;
SELECT * FROM vila;

-- MORE INSERTS:

	INSERT imobil(id, pret, client_id, proprietar_id, locatie_id) VALUES(4, 330, null, 2, 2);
	INSERT garsoniera(id, imobil_id) VALUES (2, 4);
	INSERT garsoniera(id, imobil_id) VALUES (1, 2);
	INSERT apartament(id, imobil_id) VALUES (1, 1);
	INSERT agentie(id, nume, numar_agenti) VALUES (4, 'Whatever', 0);
	-- not ok, because there is no id_imobil=7, violates referential integrity constraint.
	INSERT INTO vizita(id, id_client, id_imobil, data_vizita) VALUES (4, 1, 7, '2021-04-20');
	INSERT INTO vizita(id, id_client, id_imobil, data_vizita) VALUES (4, 2, 2, '2021-08-04');

-- UPDATE:

	UPDATE agentie
	SET numar_agenti += 1
	WHERE agentie.nume = 'Whatever';
	SELECT * FROM agentie ;

	UPDATE imobil
	SET pret -= 20
	WHERE imobil.proprietar_id = 2 AND imobil.locatie_id = 2;
	SELECT * FROM imobil ;

	UPDATE vizita
	SET data_vizita = '2021-08-02'
	WHERE data_vizita LIKE '2021-08%';
	SELECT * FROM vizita ;

	UPDATE imobil
	SET imobil.pret += 10
	WHERE imobil.locatie_id IN(1,2,3);
	SELECT * FROM imobil;

-- DELETE:

	DELETE FROM vizita 
	WHERE vizita.id_client IS NULL OR vizita.id_imobil IS NULL;
	SELECT * FROM vizita ;

	DELETE FROM imobil 
	WHERE imobil. pret BETWEEN 300 AND 400
	AND proprietar_id = 2;
	SELECT * FROM imobil;

--a UNION | OR:

	SELECT A.id,A.nume, A.prenume
	FROM agent A
	WHERE A.agentie_id = 1 OR A.agentie_id = 3
	UNION 
	SELECT C.id,C.nume, C.prenume
	FROM client C
	ORDER BY nume,prenume;

	SELECT DISTINCT TOP 3 C.id,C.nume, C.prenume
	FROM client C
	WHERE C.prenume LIKE 'D%' OR C.nume LIKE 'D%'
	UNION 
	SELECT DISTINCT TOP 3 P.id,P.nume, P.prenume
	FROM proprietar P
	WHERE  P.prenume LIKE 'D%' OR P.nume LIKE 'D%';

--b INTERSECT | IN:

	SELECT A.id,A.nume, A.prenume
	FROM agent A
	WHERE A.agentie_id IN (1,2,3)
	INTERSECT 
	SELECT C.id,C.nume, C.prenume
	FROM client C;

	SELECT A.id,A.nume, A.prenume
	FROM agent A
	INTERSECT 
	SELECT P.id, P.nume, P.prenume
	FROM proprietar P
	WHERE agentie_id IN (3,1)
	ORDER BY nume,prenume;

--c EXCEPT | NOT IN:

	SELECT I.id, I.pret, I.proprietar_id, I.locatie_id
	FROM imobil I
	WHERE I.proprietar_id NOT IN (3,2)
	EXCEPT
	SELECT I.id, I.pret, I.proprietar_id, I.locatie_id
	FROM imobil I
	WHERE I.client_id != NULL;
	
	
	SELECT V.id, V.id_imobil, V.id_client
	FROM vizita V
	WHERE V.id NOT IN (2,3)
	EXCEPT
	SELECT V.id, V.id_imobil, V.id_client
	FROM vizita V
	WHERE V.id_client = 2;

--d INNER JOIN | LEFT JOIN | RIGHT JOIN | FULL JOIN

-- INNER JOIN - joins 3 tables:

	SELECT imobil.id, imobil.pret, imobil.locatie_id, client.nume, proprietar.nume
	FROM ((imobil
	INNER JOIN client ON imobil.client_id = client.id)
	INNER JOIN proprietar ON imobil.proprietar_id = proprietar.id);

-- LEFT JOIN:

	SELECT imobil.id, vizita.id_client, vizita.data_vizita
	FROM imobil
	LEFT JOIN vizita ON imobil.id = vizita.id_imobil;

-- RIGHT JOIN:

	SELECT imobil.id, vizita.id_client, vizita.data_vizita
	FROM imobil
	RIGHT JOIN vizita ON imobil.id = vizita.id_imobil;

-- FULL JOIN - also joins 2 many to many rel.:

	SELECT imobil.id, imobil.pret, client.id, proprietar.id, locatie.id
	FROM (((imobil
	FULL JOIN client ON imobil.client_id = client.id)
	FULL JOIN proprietar ON imobil.proprietar_id = proprietar.id)
	FULL JOIN locatie ON imobil.locatie_id = locatie.id);

--e IN | WHERE | subquerries

	SELECT I.id, I.pret, I.client_id
	FROM imobil I WHERE client_id IN (SELECT client.id FROM client);

	SELECT I.id, I.pret, I.client_id
	FROM imobil I WHERE client_id IN 
				(SELECT client.id FROM client WHERE client.prenume IN 
								(SELECT proprietar.prenume FROM proprietar));

--f EXISTS | and WHERE subquery

	SELECT I.id, I.pret, I.client_id
	FROM imobil I WHERE EXISTS (SELECT client_id FROM imobil I2 WHERE I2.pret < 350 and I.id = I2.id);

	SELECT P.id, P.nume, P.agentie_id
	FROM proprietar P WHERE EXISTS (SELECT nume FROM proprietar P2 WHERE P.id = P2.id AND P2.agentie_id IS NULL);

--g subquery in FROM

	SELECT persoana.id, persoana.nume
	FROM (	
		SELECT A.id,A.nume, A.prenume
		FROM agent A
		UNION 
		SELECT C.id,C.nume, C.prenume
		FROM client C
		) AS persoana;

	SELECT in_bloc.imobil_id
	FROM (	
		SELECT A.id, A.imobil_id
		FROM apartament A
		UNION 
		SELECT G.id, G.imobil_id
		FROM garsoniera G
		) AS in_bloc;

--h GROUP BY | 3 with HAVING, of which 2 will have subquey in HAVING | use : COUNT SUM AVG MIN MAX

	SELECT count(id), locatie_id, MIN(pret)
	FROM imobil
	GROUP BY (locatie_id);

	SELECT count(id), locatie_id, MAX(pret)
	FROM imobil
	GROUP BY (locatie_id) HAVING count(id) <= 2;

	SELECT count(id),  client_id
	FROM imobil
	GROUP BY (client_id) HAVING (count(id) = (SELECT COUNT(id)  FROM imobil GROUP BY (client_id) HAVING client_id IS NULL));

	SELECT count(id),  locatie_id, avg(pret)
	FROM imobil
	GROUP BY (locatie_id) HAVING (avg(pret) < (SELECT avg(pret) FROM imobil GROUP BY (locatie_id) HAVING locatie_id = 2));

--i ANY and ALL for subq in WHERE

	SELECT id
	FROM imobil WHERE id = ANY(
	SELECT imobil_id FROM garsoniera)

	SELECT id
	FROM imobil WHERE id = ANY(
	SELECT imobil_id FROM apartament)

	SELECT imobil.id, pret
	FROM imobil
	WHERE imobil.id = ALL(SELECT imobil_id FROM garsoniera where imobil.pret <= 350 AND imobil_id = imobil.id)
	AND (SELECT imobil_id FROM garsoniera where imobil.pret <= 350 AND imobil_id = imobil.id) IS NOT NULL

	SELECT imobil.id, pret
	FROM imobil
	WHERE imobil.id = ALL(SELECT imobil_id FROM apartament where imobil.pret <= 500 AND imobil_id = imobil.id)
	AND (SELECT imobil_id FROM apartament where imobil.pret <= 500 AND imobil_id = imobil.id) IS NOT NULL

-- rewrite with IN/NOT IN

	SELECT id
	FROM imobil WHERE imobil.id IN (SELECT imobil_id FROM garsoniera)

	SELECT id
	FROM imobil WHERE imobil.id IN(SELECT imobil_id FROM apartament)

-- rewrite with agregation operators

	SELECT imobil.id, imobil.pret
	FROM imobil inner join garsoniera on imobil.id = garsoniera.imobil_id
	WHERE (SELECT max(imobil.pret) FROM imobil WHERE imobil.id = garsoniera.imobil_id) <= 350

	SELECT imobil.id, imobil.pret
	FROM imobil inner join apartament on imobil.id = apartament.imobil_id
	WHERE (SELECT max(imobil.pret) FROM imobil WHERE imobil.id = apartament.imobil_id) <= 500

