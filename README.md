# 🐾 Centro Toelettatura Animali – Progetto Basi di Dati
Repository contenente il progetto di database relazionale sviluppato per il corso di Basi di Dati (Università di Catania). Il sistema è stato progettato per la gestione completa di un centro di toelettatura per animali (cani e gatti).

# 📌 Panoramica del Progetto
Il sistema informatizzato gestisce i processi chiave di un centro di toelettatura, tra cui:

Agenda Appuntamenti: Gestione degli slot temporali (durata variabile in base alla taglia dell'animale), monitoraggio dello stato (prenotato, completato, annullato) e assegnazione degli operatori.

Anagrafica Animali e Proprietari: Monitoraggio delle caratteristiche degli animali (razza, taglia, tipologia di pelo, carattere e presenza di dermatiti) e dei contatti dei proprietari.

Gestione Operatori: Tracciamento delle specializzazioni (es. stripping, gatti, cani grandi), livello di esperienza e contatti.

Trattamenti e Magazzino Prodotti: Registrazione dei servizi effettuati (bagno medicato, taglio a forbice, ecc.) e monitoraggio in tempo reale delle scorte di prodotti disponibili.

Contabilità e Pagamenti: Registrazione dei pagamenti associati agli appuntamenti con diversi metodi (contanti, carta, bancomat) e calcolo degli incassi.

# 📐 Architettura e Progettazione
Schema E-R e Modello Concettuale
Il dominio applicativo è stato modellato attraverso un diagramma Entità-Relazione (E-R) che mappa le entità principali: Proprietario, Animale, Operatore, Appuntamento, Trattamento, Prodotto e Pagamento, oltre alle relazioni di associazione e cardinalità.

Progettazione Logica e Ottimizzazione
Tavola dei Volumi e delle Frequenze: Sono state effettuate stime previsionali sui volumi dei dati (es. ~3.000 appuntamenti, ~800 animali) e sulla frequenza mensile delle operazioni per ottimizzare le prestazioni.

Analisi delle Ridondanze: È stata valutata la convenienza di mantenere l'attributo ridondante quantità_disponibili all'interno dell'entità Prodotto. L'analisi costi/benefici (basata sul carico di lavoro delle operazioni di conteggio e registrazione trattamenti) ha dimostrato che mantenere la ridondanza riduce drasticamente i costi di accesso in lettura.

# 🔒 Vincoli e Trigger
Oltre ai vincoli strutturali dello schema relazionale, il database implementa logiche di controllo avanzate tramite Trigger MySQL per garantire la consistenza dei dati:

Verifica Sovrapposizioni (VerificaSovrapposizioni): Impedisce l'inserimento di appuntamenti sovrapposti per lo stesso operatore.

Controllo Orari di Lavoro (ControlloOrarioDiLavoro): Garantisce che gli appuntamenti rientrino nell'orario di apertura del centro (09:00 - 19:00).

Controllo Importo (ImportoPositivo): Verifica che l'importo di un pagamento sia strettamente maggiore di zero.

Disponibilità Prodotti (DisponibilitaProdotto & NumeroScorte): Controlla che vi siano scorte sufficienti in magazzino prima di registrare l'uso di un prodotto e aggiorna automaticamente le quantità disponibili post-inserimento.

# 🗂️ Struttura della Repository
La cartella del progetto contiene i seguenti script SQL (compatibili con MySQL / MySQL Workbench):

Plaintext
├── tabelle.sql        # Definizione dello schema relazionale, tabelle e vincoli di integrità
├── triggers.sql       # Implementazione dei trigger per i vincoli complessi
├── dati.sql           # Popolamento del database con dati di prova realistici
└── operazioni.sql     # Query SQL relative alle specifiche operazioni del sistema (OP1 - OP9)
# 🚀 Guida all'Installazione e Utilizzo
Per replicare e testare il database sul proprio ambiente locale (es. MySQL Workbench):

Clona la repository o scarica i file SQL.

Esegui gli script in sequenza rigorosa per evitare errori di dipendenza tra le chiavi esterne:

1) tabelle.sql (Crea il database, le tabelle e le relative FK)

2) triggers.sql (Crea le funzioni di controllo automatico)

3) dati.sql (Inserisce i dati di test)

4) operazioni.sql (Contiene le query di interrogazione e test delle funzionalità)

# 👤 Autore
Antonio Pistone (Matricola: 1000050018)

Università di Catania – Dipartimento di Matematica e Informatica

Corso di Laurea in Informatica
