CREATE DATABASE CentroToelettatura;
USE CentroToelettatura;

CREATE TABLE IF NOT EXISTS Operatore(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    specializzazione VARCHAR(50),
    numero_telefono VARCHAR(20), 
    livello_esperienza VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Proprietario(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(20),
    cognome VARCHAR(20),
    data_nascita DATE,
    contatto VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Animale(
    id INT AUTO_INCREMENT PRIMARY KEY,
    razza VARCHAR(20),
    tipologia_pelo VARCHAR(20),
    carattere VARCHAR(50),
    taglia VARCHAR(20),
    dermatiti BOOLEAN,
    id_proprietario INT NOT NULL,
    FOREIGN KEY (id_proprietario) REFERENCES Proprietario(id),
    CHECK(razza IN ('cane','gatto')),
    CHECK(taglia IN ('piccola','media','grande'))
);

CREATE TABLE IF NOT EXISTS Appuntamenti(
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_appuntamento DATE NOT NULL,
    ora_inizio TIME NOT NULL,
    ora_fine TIME NOT NULL,
    durata TIME NOT NULL,
    stato VARCHAR(20),
    id_operatore INT,
    id_animale INT,
    FOREIGN KEY (id_operatore) REFERENCES Operatore(id), 
    FOREIGN KEY (id_animale) REFERENCES Animale(id),
    CHECK(stato IN ('prenotato','completo','annullato'))
);

CREATE TABLE IF NOT EXISTS Pagamento(
    id INT AUTO_INCREMENT PRIMARY KEY,
    data_pagamento DATE NOT NULL,
    importo DECIMAL(10,2),
    metodo_pagamento VARCHAR(30),
    id_appuntamento INT,
    FOREIGN KEY (id_appuntamento) REFERENCES Appuntamenti(id),

    CHECK(metodo_pagamento IN ('contanti','carta','bancomat'))
);

CREATE TABLE IF NOT EXISTS Trattamento(
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipologia VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS Prodotto(
    id INT AUTO_INCREMENT PRIMARY KEY,
    quantita_disponibili INT DEFAULT 0,

    CHECK(quantita_disponibili>=0)
);

CREATE TABLE IF NOT EXISTS R_Include(
    id_appuntamento INT,
    id_trattamento INT,
    PRIMARY KEY (id_appuntamento, id_trattamento),
    FOREIGN KEY (id_appuntamento) REFERENCES Appuntamenti(id),
    FOREIGN KEY (id_trattamento) REFERENCES Trattamento(id)
);

CREATE TABLE IF NOT EXISTS Utilizza(
    id_trattamento INT,
    id_prodotto INT,
    quantita_usata INT,
    PRIMARY KEY (id_trattamento, id_prodotto),
    FOREIGN KEY (id_trattamento) REFERENCES Trattamento(id),
    FOREIGN KEY (id_prodotto) REFERENCES Prodotto(id)
);
