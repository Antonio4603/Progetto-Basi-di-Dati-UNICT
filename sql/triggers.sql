DELIMITER //

CREATE TRIGGER VerificaSovrapposizioni
BEFORE INSERT ON Appuntamenti
FOR EACH ROW
BEGIN
    DECLARE sovrapposizioni INT;

    SELECT COUNT(*) INTO sovrapposizioni
    FROM Appuntamenti
    WHERE id_operatore=NEW.id_operatore
      AND data_appuntamento=NEW.data_appuntamento
      AND (NEW.ora_inizio<ora_fine AND NEW.ora_fine>ora_inizio);

    IF sovrapposizioni>0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Errore: L''operatore è già impegnato in questa fascia oraria.';
    END IF;
END; //

CREATE TRIGGER ControlloOrariodiLavoro
BEFORE INSERT ON Appuntamenti
FOR EACH ROW
BEGIN
    IF NEW.ora_inizio<'09:00:00' OR NEW.ora_fine>'19:00:00' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Errore: L''appuntamento è fuori dall''orario di apertura (09:00-19:00).';
    END IF;
END; //

CREATE TRIGGER ImportoPositivo
BEFORE INSERT ON Pagamento
FOR EACH ROW
BEGIN
    IF NEW.importo<=0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Errore: L''importo del pagamento deve essere maggiore di zero.';
    END IF;
END; //

CREATE TRIGGER DisponibilitaProdotto
BEFORE INSERT ON Utilizza
FOR EACH ROW
BEGIN
    DECLARE scorta_attuale INT;

    SELECT quantita_disponibili INTO scorta_attuale
    FROM Prodotto
    WHERE id=NEW.id_prodotto;

    IF scorta_attuale<NEW.quantita_usata THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT='Errore: Prodotto insufficiente in magazzino.';
    END IF;
END; //

CREATE TRIGGER NumeroScorte
AFTER INSERT ON Utilizza
FOR EACH ROW
BEGIN
    UPDATE Prodotto 
    SET quantita_disponibili=quantita_disponibili-NEW.quantita_usata
    WHERE id=NEW.id_prodotto;
END; //

DELIMITER ;