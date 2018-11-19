-- Genutztes DBMS: MySQL 5.7.24
-- 
-- Datendefinition und -manipulation
--
-- 1. Definieren Sie mit einem SQL-Befehl eine neue Tabelle "PreiseXX"
-- mit der gleichen Struktur wie Tabelle Preise.
-- (Für XX setzen Sie die Nummer aus Ihrem Account ein!)
CREATE TABLE `Ferienhausvermietung1`.`PreiseXX`
LIKE `Ferienhausvermietung1`.`Preise`;

-- 2. Definieren Sie in der Tabelle PreiseXX einen Index für das Feld Kategorie mit der
-- Indexbezeichnung IX_KategorieXX. (Sekundärschlüssel)
ALTER TABLE `Ferienhausvermietung1`.`PreiseXX`
ADD INDEX (`Kategorie`);

-- 3. Übernehmen Sie alle Datensätze aus der Tabelle Preise in die Tabelle PreiseXX.
INSERT INTO `Ferienhausvermietung1`.`PreiseXX`
(SELECT *FROM `Ferienhausvermietung1`.`Preise`);

-- 4. Fügen Sie einen neuen vollständigen Datensatz an die Tabelle PreiseXX an.
INSERT INTO `Ferienhausvermietung1`.`PreiseXX`
VALUES (7, 'Berlin', 'Standard', 125, 500);

-- 5. Erhöhen Sie in der Tabelle PreiseXX die Wochenpreise der Häuser der Kategorie
-- "Luxus" um 10%.
UPDATE `Ferienhausvermietung1`.`PreiseXX`
SET `Wochenpreis` = `Wochenpreis` * 1.1
	WHERE `Kategorie` = 'Luxus';

-- Einfache Abfragen
--
-- 6. Zeigen Sie die Tabelle PreiseXX mit allen Feldern an.
SELECT *
FROM `Ferienhausvermietung1`.`Preise`;

-- 7. Schreiben Sie unter Verwendung der Tabelle Vermietung eine Abfrage, um nur die
-- MieterNr, die Ferienhausbezeichnung und die Termine der Vermietung zurückzugeben.
SELECT `MieterNr`, `FHaus`, `Mietbeginn`, `Mietende`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- 8. Schreiben Sie die Abfrage aus Übung 7 so um, daß Fhaus als erste Spalte in der
-- Ergebnismenge erscheint.
SELECT `FHaus`, `MieterNr`, `Mietbeginn`, `Mietende`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- 9. Schreiben Sie auf der Grundlage der Tabelle Preise eine Abfrage, die alle
-- Ferienhausorte (Feld Ort, jeden Ort nur einmal) zurückgibt.
SELECT DISTINCT `Ort`
FROM `Ferienhausvermietung1`.`Preise`;

-- Einfache Abfragen mit Auswahlbedingungen
--
-- 10. Fragen Sie alle Vermietungen ab, die nach dem 1.1.2007 erfolgten (Mietbeginn).
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE `Mietbeginn` > STR_TO_DATE('1.1.2007', '%e.%m.%Y');

-- 11. Fragen Sie alle Vermietungen ab, die zwischen dem 1.7.2007 und dem 1.9.2007
-- erfolgten (Mietbeginn). Verwenden Sie den B ETWEEN -Operator.
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE `Mietbeginn`
BETWEEN STR_TO_DATE('1.7.2007', '%e.%m.%Y')
AND STR_TO_DATE('1.9.2007', '%e.%m.%Y');

-- 12. Ermitteln Sie alle Vermietungen, die nur teilweise in den Zeitraum vom 1.7.2007 bis zum
-- 31.8.2007 (Hauptsaison) fallen.
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE (`Mietbeginn` < STR_TO_DATE('1.7.2007', '%e.%m.%Y')
AND `Mietende` > STR_TO_DATE('1.7.2007', '%e.%m.%Y'))
OR (`Mietbeginn` < STR_TO_DATE('31.8.2007', '%e.%m.%Y')
AND `Mietende` > STR_TO_DATE('31.8.2007', '%e.%m.%Y'));

-- 13. Gesucht werden alle Vermietungen des Jahres 2007, die noch nicht bezahlt sind.
SELECT *
FROM `Ferienhausvermietung1`.`Vermietung`
WHERE YEAR(`Mietende`) = 2007
AND `bezahlt` = 0;

-- 14. Suchen Sie alle Häuser der Kategorien "Standard" und „Luxus“ heraus. Benutzen Sie
-- den IN-Operator.
USE `Ferienhausvermietung1`;
SELECT `Haus`.*, `Preise`.`Kategorie`
FROM `Haus`, `Preise`
WHERE `Haus`.`Preisschl` = `Preise`.`Preisschl`
AND `Preise`.`Kategorie` IN ('Luxus', 'Standard');

-- 15. Was kosten Häuser der Kategorie "Standard"?
USE `Ferienhausvermietung1`;
SELECT `H`.`FHaus`, `P`.`Kategorie`, `P`.`Tagespreis`, `P`.`Wochenpreis` 
FROM `Haus` AS `H`, `Preise` AS `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Kategorie` = 'Standard';

-- 16. Welche Mieter kommen aus Berlin? Geben Sie Name und Telefon aus.
SELECT `Name`, `Telefon`
FROM `Ferienhausvermietung1`.`Mieter`
WHERE `Ort` = 'Berlin';

-- 17. Welche Häuser haben 3 Zimmer und mindestens 45 qm Fläche?
SELECT *
FROM `Ferienhausvermietung1`.`Haus`
WHERE `AnzZimmer` = 3
AND `Fläche` >= 45;

-- 18. Ermitteln Sie alle Mieter, in deren Postleitzahl die erste Ziffer eine 1 oder 2 ist.
SELECT *
FROM `Ferienhausveermietung1`.`Mieter`
WHERE LEFT(`PLZ`, 1) IN (1, 2);

-- Abfragen mit Aggregatfunktionen
--
-- 19. Zählen Sie die Häuser, die verwaltet werden.
SELECT count(*) as Anzahl
FROM `Ferienhausvermietung1`.`Haus`;

-- 20. Wieviel Häuser haben 4 Zimmer?
SELECT count(*) as Anzahl
FROM `Ferienhausvermietung1`.`Haus`
WHERE `AnzZimmer` = 4;

-- 21. Ermitteln Sie die Gesamtsumme der Vermietungseinnahmen.
SELECT SUM(`Betrag`) AS `Summe`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- 22. Wieviel wurde durchschnittlich pro Vermietung eingenommen?
SELECT AVG(`Betrag`) AS `Durchschnitt`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- 23. Teuerstes und preiswertestes Angebot - ermitteln Sie bitte nur die beiden Preise!
SELECT MIN(`Betrag`) AS `Minimum`, MAX(`Betrag`) AS `Maximum`
FROM `Ferienhausvermietung1`.`Vermietung`;

-- Abfragen mit Gruppenbildung und Gruppenselektion
--
-- 24. Ermitteln Sie die durchschnittliche Zimmerfläche der Häuser gruppiert nach AnzZimmer.
SELECT ROUND(AVG(`Fläche`)/`AnzZimmer`, 2) as `Durchschnitt (Fläche/Zimmer)`
FROM `Ferienhausvermietung1`.`Haus`
GROUP BY `AnzZimmer`;

-- 25. Bestimmen Sie die Anzahl der Vermietungen pro Kunde (Mieternr).
USE `Ferienhausvermietung1`;
SELECT `Mieter`.`Name`, COUNT(*) AS `Anzahl`
FROM `Vermietung`, `Mieter`
WHERE `Vermietung`.`MieterNr` = `Mieter`.`MieterNr`
GROUP BY `Mieter`.`Name`;

-- 26. Wie hoch waren die Mieteinnahmen pro Mieter und Ferienhaus.
USE `Ferienhausvermietung1`;
SELECT `M`.`Name`, `V`.`FHaus`, SUM(`V`.`Betrag`) AS `Summe`
FROM `Mieter` AS `M`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
GROUP BY `M`.`Name`, `V`.`FHaus`;

-- 27. Bestimmen Sie die Summe der Mieteinnahmen derjenigen Mieter, die mehrere
-- Buchungen haben.
SELECT `MieterNr`, SUM(`Betrag`) AS `Summe`
FROM `Ferienhausvermietung1`.`Vermietung`
GROUP BY `MieterNr`
HAVING COUNT(*) >= 2;

-- Abfragen über mehrere Tabellen
--
-- 28. Was kosten Häuser der Kategorie "Luxus", die mindestens 50 qm Fläche aufweisen?
USE `Ferienhausvermietung1`;
SELECT `H`.`FHaus`, `P`.`Tagespreis`, `P`.`Wochenpreis`
FROM `Haus` AS `H`, `Preise` AS `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Kategorie`='Luxus';

-- 29. Welche Häuser sind in Hinterthal?
USE `Ferienhausvermietung1`;
SELECT `H`.`FHaus`, `P`.`Ort`
FROM `Preise` AS `P`, `Haus` AS `H`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Ort`='Hinterthal';

-- 30. Welche Vermietungen liefen zu einem Wochenpreis?
USE `Ferienhausvermietung1`;
SELECT `V`.*
FROM `Vermietung` AS `V`, `Preise` AS `P`, `Haus` AS `H`
WHERE `V`.`FHaus` = `H`.`FHaus`
AND `H`.`Preisschl` = `P`.`Preisschl`
AND`V`.`Betrag` % `P`.`Wochenpreis`=0;

-- 31. Welche Mieter mieteten ein 3-Zimmer-Haus?
USE `Ferienhausvermietung1`;
SELECT `M`.*, COUNT(*) AS `Wie oft?`
FROM `Mieter` AS `M`, `Haus` AS `H`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`FHaus` = `H`.`FHaus`
AND `H`.`AnzZimmer` = 3
GROUP BY `V`.`MieterNr`;

-- 32. Welche Mieter müssen noch zahlen?
USE `Ferienhausvermietung1`;
SELECT `M`.*, `V`.`Betrag`
FROM `Mieter` AS `M`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`bezahlt` = 0;

-- 33. Welche Mieter haben nicht angezahlt?
USE `Ferienhausvermietung1`;
SELECT `M`.*
FROM `Mieter` AS `M`, `Vermietung` AS `V`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`Anzahlung` = 0;

-- 34. Bei welchen Häusern liegt der Wochenpreis um mehr als 20% unter dem 7fachen des
-- Tagespreises?
USE `Ferienhausvermietung1`;
SELECT `H`.*
FROM `Haus` AS `H`, `Preise` as `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Wochenpreis` * (1 - 0.2) < `P`.`Tagespreis` * 7;

-- Unterabfragen
--
-- 35. Ermitteln Sie die Häuser, deren Wochenpreis über dem Durchschnittspreis liegt.
USE `Ferienhausvermietung1`;
SELECT *
FROM `Haus` AS `H`, `Preise` AS `P`
WHERE `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Wochenpreis` > (SELECT AVG(`Wochenpreis`) FROM `Preise`);

-- 36. Bestimmen Sie die Namen der Mieter, die an Häusern interessiert sind, die über dem
-- Durchschnittspreis liegen.
USE `Ferienhausvermietung1`;
SELECT `M`.*
FROM `Mieter` AS `M`, `Vermietung` AS `V`, `Preise` AS `P`, `Haus` AS `H`
WHERE `M`.`MieterNr` = `V`.`MieterNr`
AND `V`.`FHaus` = `H`.`FHaus`
AND `H`.`Preisschl` = `P`.`Preisschl`
AND `P`.`Wochenpreis` > (SELECT AVG(`Wochenpreis`) FROM `Preise`);

-- 37. Ermitteln Sie mit der Unterabfragetechnik die Häuser, die zum aktuellen Datum in
-- Hinterthal nicht vermietet sind.
USE `Ferienhausvermietung1`;
SELECT `H`.*
FROM `Haus` AS `H`
WHERE `H`.`FHaus` IN
(
	SELECT `V`.FHaus FROM `Vermietung` AS `V`
	WHERE CURDATE() NOT BETWEEN `V`.`Mietbeginn` AND `V`.`Mietende`
);

-- 38. Ermitteln Sie mit der Unterabfragetechnik, welche Mieter mehrfach das gleiche Haus
-- gemietet haben. Für diese Vermietungen sollen die Hausbezeichnung und die Termine
-- ausgegeben werden.
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

-- Weitere Aufgaben zu verschiedenen JOIN-Typen
--
-- 39. Welche Mieter haben den gleichen Vermietungsbetrag gezahlt? (SELFJOIN)
USE `Ferienhausvermietung1`;
SELECT DISTINCT `V_A`.`MieterNr`, `V_A`.`Betrag`
FROM `Vermietung` AS `V_A`, `Vermietung` AS `V_B`
WHERE `V_A`.`Betrag` = `V_B`.`Betrag`
AND `V_A`.`MieterNr` <> `V_B`.`MieterNr`;

-- 40. Zur Vorbereitung auf die nächsten Abfragen geben Sie bitte ein neues Ferienhaus in die
-- Tabelle Haus ein.
INSERT INTO `Ferienhausvermietung1`.`Haus`
VALUES ('Fink', 4, 55, 2);

-- 41. Zur Vorbereitung auf die nächsten Abfragen geben Sie bitte einen neuen Kunden in die
-- Tabelle Mieter ein. Dieser Kunde ist zunächst ein Interessent, will im Moment aber noch
-- kein Ferienhaus mieten.
INSERT INTO `Ferienhausvermietung1`.`Mieter`
VALUES (7, 'Schulze', '12345', 'Berlin', 'Straße 1', '987654321');

-- 42. Geben Sie alle Kunden aus und, falls vorhanden, die dazugehörigen Buchungen/
-- Vermietungen.
USE `Ferienhausvermietung1`;
SELECT *
FROM `Mieter` AS `M`
LEFT JOIN `Vermietung` AS `V`
ON `M`.`MieterNr` = `V`.`MieterNr`;

-- 43. Geben Sie alle Ferienhäuser aus, die noch nie vermietet wurden.
USE `Ferienhausvermietung1`;
SELECT `H`.* FROM `Haus` AS `H`
LEFT JOIN `Vermietung` AS `V` ON `V`.`FHaus` = `H`.`FHaus`
WHERE `V`.`VNr` IS NULL;

-- 44. Geben Sie alle Ferienhäuser aus, die im September 2007 frei sind. (Lösung über
-- Unterabfrage)
USE `Ferienhausvermietung1`;
SELECT *
FROM `Haus`
WHERE FHaus IN (
	SELECT `V`.`FHaus`
	FROM `Vermietung` AS `V`
	WHERE `V`.`Mietbeginn` > '2007-09-01'
	AND `V`.`Mietende` < '2007-09-30'
);

-- 45. Lassen Sie sich sämtliche Ferienhäuser und Mieter in einer Tabelle anzeigen. Es soll
-- Mietbeginn und Mietende zusätzlich ausgegeben werden, wenn eine Vermietung vorlag.
-- Die Anzeige ist nach Fhaus und Mietbeginn zu sortieren.
-- ÜBERPRÜFEN!!!
USE `Ferienhausvermietung1`;
SELECT `H`.*, `M`.*, `V`.`Mietbeginn`, `V`.`Mietende`
FROM `Vermietung` AS `V`
INNER JOIN `Mieter` AS `M` ON
	`M`.`MieterNr` = `V`.`MieterNr`
RIGHT JOIN `Haus` AS `H` ON
	`H`.`FHaus` = `V`.`FHaus`
ORDER BY `H`.`FHaus`, `V`.`Mietbeginn`;

-- 46. Wählen Sie eine der zuvor ausgeführten Abfragen aus und speichern Sie diese als Sicht
-- auf dem Server.
CREATE VIEW `Freie_Haeuser`
AS SELECT *
FROM `Haus`
WHERE FHaus IN (
	SELECT `V`.`FHaus`
	FROM `Vermietung` AS `V`
	WHERE `V`.`Mietbeginn` > '2007-09-01'
	AND `V`.`Mietende` < '2007-09-30'
);

-- 47. Erstellen Sie eine Sicht, die alle noch nicht bezahlten Vermietungen anzeigt (alle
-- Vermietungsdaten).
-- Führen Sie die Sicht aus! (im Objektkatalog die Sicht markieren, Kontextmenü „Öffnen“)
CREATE VIEW `nicht_bezahlte_Vermietungen`
AS SELECT *
FROM `Vermietung` AS `V`
WHERE `V`.`bezahlt` = 0;

SELECT *
FROM `Ferienhausvermietung1`.`nicht_bezahlte_Vermietungen` AS `NBV`;

-- 48. Verwenden Sie die Sicht zur Zahlungskontrolle (Mahnwesen), indem Sie durch eine
-- Abfrage alle Datensätze der Sicht herausfiltern, deren Mietbeginn vor einem von Ihnen
-- festzulegenden Stichtag liegt.
SELECT *
FROM `Ferienhausvermietung1`.`nicht_bezahlte_Vermietungen` AS `NBV`
WHERE `NBV`.`Mietbeginn` < '2008-01-01';

-- 49. Verwenden Sie die Sicht, um Vermietung zu aktualisieren. Wenn ein Mieter zahlt, soll
-- nach Vorgabe der VNr bezahlt =1 gesetzt werden.
UPDATE `Ferienhausvermietung1`.`nicht_bezahlte_Vermietungen` AS `NBV`
SET `NBV`.`bezahlt` = 1
	WHERE `NBV`.`VNr` = 17;er
	
