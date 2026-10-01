-- OP1 Inserimento di un nuovo appuntamento
INSERT INTO Appuntamenti (data_appuntamento, ora_inizio, ora_fine, durata, stato, id_operatore, id_animale)
VALUES('2026-06-03', '10:30:00', '11:30:00', '01:00:00', 'prenotato', 1, 1);

-- OP2 Visualizzazione degli appuntamenti in una determinata data
SELECT * 
FROM Appuntamenti 
WHERE data_appuntamento='2026-06-03';

-- OP3 Visualizzazione degli appuntamenti associati ad un operatore
SELECT * 
FROM Appuntamenti 
WHERE id_operatore=1;

-- OP4 Visualizzazione dello storico degli appuntamenti di un animale
SELECT * 
FROM Appuntamenti 
WHERE id_animale=1;

-- OP5 Conteggio dei prodotti disponibili
SELECT SUM(quantita_disponibili) AS totale_prodotti 
FROM Prodotto;

-- OP6 Registrazione di un pagamento associato ad un appuntamento
INSERT INTO Pagamento (data_pagamento, importo, metodo_pagamento, id_appuntamento)
VALUES('2026-06-03', 45.00, 'carta', 1);

-- OP7 Calcolo dell'incasso totale in un determinato periodo
SELECT SUM(importo) AS incasso_totale 
FROM Pagamento 
WHERE data_pagamento BETWEEN '2026-02-01' AND '2026-06-03';

-- OP8 Registrazione di un trattamento effettuato durante un appuntamento
INSERT INTO R_Include (id_appuntamento, id_trattamento) 
VALUES (3, 1);

-- OP9 Visualizzazione dei trattamenti effettuati su un animale
SELECT T.tipologia 
FROM Trattamento T 
JOIN R_Include I ON T.id=I.id_trattamento
JOIN Appuntamenti A ON I.id_appuntamento=A.id
WHERE A.id_animale=1;