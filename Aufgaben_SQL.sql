-- Genutztes DBMS: MySQL 5.7.24
-- Aufgabe 1
CREATE TABLE `Ferienhausvermietung1`.`PreiseXX`
LIKE `Ferienhausvermietung1`.`Preise`;

-- Aufgabe 2
ALTER TABLE `Ferienhausvermietung1`.`PreiseXX`
ADD INDEX (`Kategorie`);

-- Aufgabe 3
INSERT INTO `Ferienhausvermietung1`.`PreiseXX`
(SELECT *FROM `Ferienhausvermietung1`.`Preise`);

-- Aufgabe 4
INSERT INTO `Ferienhausvermietung1`.`PreiseXX`
VALUES (7, 'Berlin', 'Standard', 125, 500);

-- Aufgabe 5
UPDATE `Ferienhausvermietung1`.`PreiseXX`
SET `Wochenpreis` = `Wochenpreis` * 1.1
	WHERE `Kategorie` = 'Luxus';

-- Aufgabe 6
SELECT *
FROM `Ferienhausvermietung1`.`Preise`;

-- Aufgabe 7
SELECT `MieterNr`, `FHaus`, `Mietbeginn`, `Mietende`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- Aufgabe 8
SELECT `FHaus`, `MieterNr`, `Mietbeginn`, `Mietende`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- Aufgabe 9
SELECT DISTINCT `Ort`
FROM `Ferienhausvermietung1`.`Preise`;

-- Aufgabe 10
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE `Mietbeginn` > STR_TO_DATE('1.1.2007', '%e.%m.%Y');

-- Aufgabe 11
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE `Mietbeginn`
BETWEEN STR_TO_DATE('1.7.2007', '%e.%m.%Y')
AND STR_TO_DATE('1.9.2007', '%e.%m.%Y');

-- Aufgabe 12
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE (`Mietbeginn` < STR_TO_DATE('1.7.2007', '%e.%m.%Y')
AND `Mietende` > STR_TO_DATE('1.7.2007', '%e.%m.%Y'))
OR (`Mietbeginn` < STR_TO_DATE('31.8.2007', '%e.%m.%Y')
AND `Mietende` > STR_TO_DATE('31.8.2007', '%e.%m.%Y'));

-- Aufgabe 13
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE YEAR(`Mietende`) = 2007
AND `bezahlt` = 0;

-- Aufgabe 14
USE `Ferienhausvermietung1`;
SELECT `Haus`.*, `Preise`.`Kategorie`
FROM `Haus`, `Preise`
WHERE `Haus`.`Preisschl` = `Preise`.`Preisschl`
AND `Preise`.`Kategorie` IN ('Luxus', 'Standard');

-- Aufgabe 15
USE `Ferienhausvermietung1`;
SELECT `H`.`FHaus`, `P`.`Kategorie`, `P`.`Tagespreis`, `P`.`Wochenpreis` 
FROM `Haus` AS `H`, `Preise` AS `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Kategorie` = 'Standard';

-- Aufgabe 16
SELECT `Name`, `Telefon`
FROM `Ferienhausvermietung1`.`Mieter`
WHERE `Ort` = 'Berlin';

-- Aufgabe 17
SELECT *
FROM `Ferienhausvermietung1`.`Haus`
WHERE `AnzZimmer` = 3
AND `Fläche` >= 45;

-- Aufgabe 18
SELECT *
FROM `Ferienhausveermietung1`.`Mieter`
WHERE LEFT(`PLZ`, 1) IN (1, 2);

-- Aufgabe 19
SELECT count(*) as Anzahl
FROM `Ferienhausvermietung1`.`Haus`;

-- Aufgabe 20
SELECT count(*) as Anzahl
FROM `Ferienhausvermietung1`.`Haus`
WHERE `AnzZimmer` = 4;

-- Aufgabe 21
SELECT SUM(`Betrag`) AS `Summe`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- Aufgabe 22
SELECT AVG(`Betrag`) AS `Durchschnitt`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- Aufgabe 23
SELECT MIN(`Betrag`) AS `Minimum`, MAX(`Betrag`) AS `Maximum`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- Aufgabe 24
SELECT ROUND(AVG(`Fläche`)/`AnzZimmer`, 2) as `Durchschnitt (Fläche/Zimmer)`
FROM `Ferienhausvermietung1`.`Haus`
GROUP BY `AnzZimmer`;

-- Aufgabe 25
USE `Ferienhausvermietung1`;
SELECT `Mieter`.`Name`, COUNT(*) AS `Anzahl`
FROM `Vermietung`, `Mieter`
WHERE `Vermietung`.`MieterNr` = `Mieter`.`MieterNr`
GROUP BY `Mieter`.`Name`;

-- Aufgabe 26
USE `Ferienhausvermietung1`;
SELECT `M`.`Name`, `V`.`FHaus`, SUM(`V`.`Betrag`) AS `Summe`
FROM `Mieter` AS `M`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
GROUP BY `M`.`Name`, `V`.`FHaus`;

-- Aufgabe 27
SELECT `MieterNr`, SUM(`Betrag`) AS `Summe`
FROM `Ferienhausvermietung1`.`Vermietung`
GROUP BY `MieterNr`
HAVING COUNT(*) >= 2;

-- Aufgabe 28
USE `Ferienhausvermietung1`;
SELECT `H`.`FHaus`, `P`.`Tagespreis`, `P`.`Wochenpreis`
FROM `Haus` AS `H`, `Preise` AS `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Kategorie`='Luxus';

-- Aufgabe 29
USE `Ferienhausvermietung1`;
SELECT `H`.`FHaus`, `P`.`Ort`
FROM `Preise` AS `P`, `Haus` AS `H`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Ort`='Hinterthal';

-- Aufgabe 30
USE `Ferienhausvermietung1`;
SELECT `V`.*
FROM `Vermietung` AS `V`, `Preise` AS `P`, `Haus` AS `H`
WHERE `V`.`FHaus` = `H`.`FHaus`
AND `H`.`Preisschl` = `P`.`Preisschl`
AND`V`.`Betrag` % `P`.`Wochenpreis`=0;

-- Aufgabe 31
USE `Ferienhausvermietung1`;
SELECT `M`.*, COUNT(*) AS `Wie oft?`
FROM `Mieter` AS `M`, `Haus` AS `H`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`FHaus` = `H`.`FHaus`
AND `H`.`AnzZimmer` = 3
GROUP BY `V`.`MieterNr`;

-- Aufgabe 32
USE `Ferienhausvermietung1`;
SELECT `M`.*, `V`.`Betrag`
FROM `Mieter` AS `M`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`bezahlt` = 0;

-- Aufgabe 33
USE `Ferienhausvermietung1`;
SELECT `M`.*
FROM `Mieter` AS `M`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`Anzahlung` = 0;

-- Aufgabe 34
USE `Ferienhausvermietung1`;
SELECT `H`.*
FROM `Haus` AS `H`, `Preise` as `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Wochenpreis` * (1 - 0.2) < `P`.`Tagespreis` * 7;

-- Aufgabe 35
USE `Ferienhausvermietung1`;
SELECT *
FROM `Haus` AS `H`, `Preise` AS `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Wochenpreis` > (SELECT AVG(`Wochenpreis`) FROM `Preise`);

-- Aufgabe 36
USE `Ferienhausvermietung1`;
SELECT `M`.*
FROM `Mieter` AS `M`, `Vermietung` AS `V`, `Preise` AS `P`, `Haus` AS `H`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`FHaus` = `H`.`FHaus`
AND `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Wochenpreis` > (SELECT AVG(`Wochenpreis`) FROM `Preise`);

-- Aufgabe 37
USE `Ferienhausvermietung1`;
SELECT `H`.*
FROM `Haus` AS `H`
WHERE `H`.`FHaus` IN
(
	SELECT `V`.FHaus FROM `Vermietung` AS `V`
	WHERE CURDATE() NOT BETWEEN `V`.`Mietbeginn` AND `V`.`Mietende`
);

-- Aufgabe 38
USE `Ferienhausvermietung1`;
SELECT `M`.`Name`, `V`.`FHaus`, `V`.`Mietbeginn`, `V`.`Mietende`
FROM `Vermietung` AS `V`
INNER JOIN `Mieter` AS `M` ON `V`.`MieterNr` = `M`.`MieterNr`
WHERE `V`.`FHaus` IN
	(SELECT `V_s`.`FHaus` FROM `Vermietung` AS `V_s`
    GROUP BY `V_s`.`FHaus`, `V_s`.`MieterNr`
    HAVING COUNT(*) > 1)
AND `V`.`MieterNr` IN
	(SELECT `V_s`.`MieterNr` FROM `Vermietung` AS `V_s`
    GROUP BY `V_s`.`FHaus`, `V_s`.`MieterNr`
    HAVING COUNT(*) > 1);

-- Aufgabe 39
USE `Ferienhausvermietung1`;
SELECT DISTINCT `V_A`.`MieterNr`, `V_A`.`Betrag`
FROM `Vermietung` AS `V_A`, `Vermietung` AS `V_B`
WHERE `V_A`.`Betrag` = `V_B`.`Betrag`
AND `V_A`.`MieterNr` <> `V_B`.`MieterNr`;

-- Aufgabe 40
INSERT INTO `Ferienhausvermietung1`.`Haus`
VALUES ('Neues Haus', 4, 55, 2);

-- Aufgabe 41
INSERT INTO `Ferienhausvermietung1`.`Mieter`
VALUES (7, 'Dombrowski', '12345', 'Berlin', 'Straße 1', '987654321');

-- Aufgabe 42
USE `Ferienhausvermietung1`;
SELECT *
FROM `Mieter` AS `M`
LEFT JOIN `Vermietung` AS `V`
ON `M`.`MieterNr` = `V`.`MieterNr`;

-- Aufgabe 43
USE `Ferienhausvermietung1`;
SELECT `H`.* FROM `Haus` AS `H`
LEFT JOIN `Vermietung` AS `V` ON `V`.`FHaus` = `H`.`FHaus`
WHERE `V`.`VNr` IS NULL;

-- Aufgabe 44
USE `Ferienhausvermietung1`;
SELECT *
FROM `Haus`
WHERE FHaus IN (
	SELECT `V`.`FHaus`
	FROM `Vermietung` AS `V`
	WHERE `V`.`Mietbeginn` > '2007-09-01'
	AND `V`.`Mietende` < '2007-09-30'
);

-- Aufgabe 45
-- ÜBERPRÜFEN!!!
USE `Ferienhausvermietung1`;
SELECT `H`.*, `M`.*, `V`.`Mietbeginn`, `V`.`Mietende`
FROM `Vermietung` AS `V`
INNER JOIN `Mieter` AS `M` ON
	`M`.`MieterNr` = `V`.`MieterNr`
RIGHT JOIN `Haus` AS `H` ON
	`H`.`FHaus` = `V`.`FHaus`
ORDER BY `H`.`FHaus`, `V`.`Mietbeginn`;

-- Aufgabe 46
CREATE VIEW `Freie_Haeuser`
AS SELECT *
FROM `Haus`
WHERE FHaus IN (
	SELECT `V`.`FHaus`
	FROM `Vermietung` AS `V`
	WHERE `V`.`Mietbeginn` > '2007-09-01'
	AND `V`.`Mietende` < '2007-09-30'
);

-- Aufgabe 47
CREATE VIEW `nicht_bezahlte_Vermietungen`
AS SELECT *
FROM `Vermietung` AS `V`
WHERE `V`.`bezahlt` = 0;

SELECT *
FROM `Ferienhausvermietung1`.`nicht_bezahlte_Vermietungen` AS `NBV`;

-- Aufgabe 48
SELECT *
FROM `Ferienhausvermietung1`.`nicht_bezahlte_Vermietungen` AS `NBV`
WHERE `NBV`.`Mietbeginn` < '2008-01-01';

-- Aufgabe 49
UPDATE `Ferienhausvermietung1`.`nicht_bezahlte_Vermietungen` AS `NBV`
SET `NBV`.`bezahlt` = 1
	WHERE `NBV`.`VNr` = 17;
