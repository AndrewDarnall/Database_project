# -- Script creazione della base di dati

drop schema operaDB;

drop user 'ospite'@'localhost';
drop user 'gestore'@'localhost';

create schema operaDB;

use operaDB;

# -- Creazione delle tabelle

create table Opera 
(
    titolo_opera varchar(100) primary key,
    data_opera_lirica datetime
);

create table Orchestra
(
    nome_orchestra varchar(45) primary key,
    n_musicisti int not null,
    tipologia_orchestra varchar(45) not null,
    direttore_orchestra varchar(50) not null,
    titolo_opera varchar(100) not null,
    foreign key (titolo_opera) references Opera(titolo_opera)
);

create table Libretto
(
    titolo varchar(45) primary key,
    autore varchar(50) not null,
    n_pagine int not null,
    titolo_opera varchar(100) not null,
    foreign key (titolo_opera) references Opera(titolo_opera)
);

create table Attore 
(
    codice_fiscale_attore varchar(16) primary key,
    nome_attore varchar(10) not null,
    cognome_attore varchar(25) not null
);

create table Esibizione
(
    titolo_opera varchar(100) not null,
    codice_fiscale_attore varchar(16) not null,   
    ruolo_attore varchar(50) not null,
    primary key (titolo_opera,codice_fiscale_attore),
    foreign key (titolo_opera) references Opera(titolo_opera),
    foreign key (codice_fiscale_attore) references Attore(codice_fiscale_attore)
);

create table Atti
(
    n_atto int not null,
    titolo_opera varchar(100) not null,
    durata_atto int not null,
    primary key (n_atto,titolo_opera),
    foreign key (titolo_opera) references Opera(titolo_opera)
);

create table Scena
(
    titolo_scena varchar(30) not null,
    titolo_opera varchar(100) not null,
    n_atto int not null,
    durata int not null,
    primary key (titolo_scena,titolo_opera,n_atto),
    foreign key (titolo_opera) references Opera(titolo_opera),
    foreign key (n_atto) references Atti(n_atto)
);

create table Suona
(
    nome_orchestra varchar(45) not null,
    titolo_scena varchar(30) not null,
    n_atto int not null,
    titolo_opera varchar(100) not null,
    titolo_brano varchar(45) not null,
    primary key(nome_orchestra,titolo_scena,n_atto,titolo_opera),
    foreign key (nome_orchestra) references Orchestra(nome_orchestra),
    foreign key (titolo_scena) references Scena(titolo_scena),
    foreign key (n_atto) references Atti(n_atto),
    foreign key (titolo_opera) references Opera(titolo_opera)
);

create table PartecipaScena
(
    titolo_scena varchar(30) not null,
    codice_fiscale_attore varchar(16) not null,
    n_atto int not null,
    titolo_opera varchar(100) not null,
    primary key (titolo_scena,n_atto,titolo_opera),
    foreign key (titolo_scena) references Scena(titolo_scena),
    foreign key (codice_fiscale_attore) references Attore(codice_fiscale_attore),
    foreign key (n_atto) references Atti(n_atto),
    foreign key (titolo_opera) references Opera(titolo_opera)
);

# -- Popolazione della tabella Opera

insert into Opera(titolo_opera, data_opera_lirica) values ('Sigfriddo','2022-03-07 18:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('La Gioconda','2022-03-08 18:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('Parsifal', '2022-03-09 17:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('Le Villi', '2022-03-10 19:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('Cavalleria rusticana', '2022-03-11 18:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('Otello', '2022-03-12');
insert into Opera(titolo_opera, data_opera_lirica) values ('Elettra', '2022-03-13 18:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('La rondine', '2022-03-14 18:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('Il cavaliere della rosa', '2022-03-15 18:00:00');
insert into Opera(titolo_opera, data_opera_lirica) values ('Madama Butterfly', '2022-03-16 16:00:00');

# -- Popolazione della tabella Orchestra

insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Academia Montis Regalis', 50, 'Barocca', 'Emmanuele Verdi', 'Sigfriddo');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Ars Cantus', 50, 'da Camera', 'Giovanni Tenti', 'La Gioconda');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Camerata Ducale', 50, 'da Camera', 'Guido Rimonda', 'Parsifal');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Cappella Andrea Barca', 50, 'Barocca', 'Andràs Schiff', 'Le Villi');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('LaBarocca', 50, 'Barocca', 'Ruben Jais', 'Cavalleria rusticana');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('I Musici', 50, 'Barocca', 'Giuseppe Maghi', 'Otello');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Filarmonica del Teatro Comunale di Bologna', 50, 'Sinfonica', 'Alberto Veronesi', 'Elettra');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Filarmonica di Tivoli', 50, 'Filarmonica', 'Franco Romanzi', 'La rondine');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Il Giardino Armonico', 50, 'Barocca', 'Giovanni Antonini', 'Il cavaliere della rosa');
insert into Orchestra(nome_orchestra, n_musicisti, tipologia_orchestra, direttore_orchestra, titolo_opera) values ('Orchestra di Padova e del Veneto', 50, 'Classica', 'Claudio Scimone', 'Madama Butterfly');

# -- Popolazione della tabella Libretto

insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Sigfriddo', 'Richard Wagner', 25, 'Sigfriddo');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('La Gioconda', 'Amicare Ponchielli', 26, 'La Gioconda');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Parsifal', 'Richard Wagner', 34, 'Parsifal');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Le Villi', 'Giacomo Puccini', 24, 'Le Villi');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Cavalleria rusticana', 'Pietro Mascagni', 34, 'Cavalleria rusticana');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Otello', 'Giuseppe Verdi', 30, 'Otello');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Elettra', 'Richard Strauss', 26, 'Elettra');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('La rondine', 'Giacomo Puccini',33 , 'La rondine');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Il cavaliere della rosa', 'Richard Strauss', 32, 'Il cavaliere della rosa');
insert into Libretto(titolo, autore, n_pagine, titolo_opera) values ('Madama Butterfly', 'Giacomo Puccini', 34, 'Madama Butterfly');

# -- Popolazione della tabella Attore

insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('DFMMO10X342S', 'Massimo', 'Verdi');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('DFMMJ20Y234S', 'Catia', 'Niscemi');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('ACBFR43U321I', 'Giuseppe', 'Angeli');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('NJHFG21O982L', 'Marco', 'Vivi');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('DDJJH92U909K', 'Eleonora', 'Colti');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('DFMMM22X555X', 'Mario', 'nonRossi');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('AAKLS41V987O', 'Michele', 'nonBravi');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('JGKFH89U098L', 'Federica', 'Pausetta');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('VMDKL88T987N', 'Valerio', 'Finocchiaro');
insert into Attore(codice_fiscale_attore, nome_attore, cognome_attore) values ('LAKSC56T534U', 'Aldo', 'nonBaglio');

# -- Popolazione della tabella Atti

insert into Atti(n_atto, titolo_opera, durata_atto) values (1 , 'Madama Butterfly', 60);
insert into Atti(n_atto, titolo_opera, durata_atto) values (2 , 'Madama Butterfly', 45);
insert into Atti(n_atto, titolo_opera, durata_atto) values (1 , 'Otello', 120);
insert into Atti(n_atto, titolo_opera, durata_atto) values (4 , 'Elettra', 60);
insert into Atti(n_atto, titolo_opera, durata_atto) values (3 , 'Elettra', 60);
insert into Atti(n_atto, titolo_opera, durata_atto) values (1 , 'Elettra', 60);
insert into Atti(n_atto, titolo_opera, durata_atto) values (2 , 'Elettra', 60);
insert into Atti(n_atto, titolo_opera, durata_atto) values (2 , 'La rondine', 45);
insert into Atti(n_atto, titolo_opera, durata_atto) values (1 , 'La rondine', 55);
insert into Atti(n_atto, titolo_opera, durata_atto) values (1 , 'Parsifal', 120);

# -- Popolazione della tabella Esibizione

insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Madama Butterfly', 'DFMMJ20Y234S', 'Madama Butterfly');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Madama Butterfly', 'DDJJH92U909K', 'Personaggio 1');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Elettra', 'DFMMJ20Y234S', 'Elettra');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Elettra', 'LAKSC56T534U', 'Personaggio 11');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('La rondine', 'JGKFH89U098L', 'Nobile');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Parsifal', 'DFMMJ20Y234S', 'Il Parsifal');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Otello', 'ACBFR43U321I', 'Nobile 2');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Otello', 'LAKSC56T534U', 'Nobile 3');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Parsifal', 'DFMMO10X342S', 'Ausilio');
insert into Esibizione(titolo_opera, codice_fiscale_attore, ruolo_attore) values ('Madama Butterfly', 'VMDKL88T987N', 'Personaggio 3');

# -- Popolazione della tabella Scena

insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 1', 'Parsifal', 1, 15);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 2', 'Parsifal', 1, 4);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 3', 'Parsifal', 1, 5);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 4', 'Parsifal', 1, 10);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 1', 'Parsifal', 2, 18);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 2', 'Parsifal', 2, 15);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 3', 'Parsifal', 2, 5);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 4', 'Parsifal', 2, 10);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 1', 'Parsifal', 3, 15);
insert into Scena(titolo_scena, titolo_opera, n_atto, durata) values ('Scena 2', 'Parsifal', 3, 20);

# -- Popolazione della tabella Suona

insert into Suona(nome_orchestra, titolo_scena, n_atto, titolo_opera, titolo_brano) values ('Academia Montis Regalis', 'Scena 1', 1, 'Parsifal','Il Giardino');
insert into Suona(nome_orchestra, titolo_scena, n_atto, titolo_opera, titolo_brano) values ('Academia Montis Regalis', 'Scena 2', 1, 'Parsifal','La dama');
insert into Suona(nome_orchestra, titolo_scena, n_atto, titolo_opera, titolo_brano) values ('Academia Montis Regalis', 'Scena 3', 1, 'Parsifal','melodia');
insert into Suona(nome_orchestra, titolo_scena, n_atto, titolo_opera, titolo_brano) values ('Academia Montis Regalis', 'Scena 4', 1, 'Parsifal','finale_scena');

# -- Popolazione della tabella PartecipaScena

insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 1', 'VMDKL88T987N', 1, 'Elettra');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 2', 'DFMMO10X342S', 1, 'Elettra');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 3', 'LAKSC56T534U', 1, 'Elettra');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 1', 'VMDKL88T987N', 2, 'Parsifal');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 3', 'DFMMO10X342S', 3, 'Parsifal');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 2', 'VMDKL88T987N', 3, 'Parsifal');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 1', 'VMDKL88T987N', 3, 'Parsifal');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 1', 'LAKSC56T534U', 2, 'Madama Butterfly');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 2', 'VMDKL88T987N', 2, 'Madama Butterfly');
insert into PartecipaScena(titolo_scena, codice_fiscale_attore, n_atto, titolo_opera) values ('Scena 3', 'DFMMJ20Y234S', 2, 'Madama Butterfly');

# -- Creao una viste per nascondere il codice fiscale degli attori

create view Attori as 
select nome_attore as nome, cognome_attore as cognome 
from Attore;

create view PartScene as 
select titolo_scena, n_atto, titolo_opera
from PartecipaScena;

create view EsibizioneAttore as
select titolo_opera as opera, nome_attore as nome, cognome_attore as cognome, ruolo_attore as ruolo_attore
from Attore join Esibizione on Esibizione.codice_fiscale_attore = Attore.codice_fiscale_attore;

# -- Di seguito la creazione degli utenti

create user 'ospite'@'localhost' identified by '123456';
create user 'gestore'@'localhost' identified by '654321';

# -- Privilegi ospite

grant select on operaDB.Attori to 'ospite'@'localhost';
grant select on operaDB.PartScene to 'ospite'@'localhost';
grant select on operaDB.EsibizioneAttore to 'ospite'@'localhost';
grant select on operaDB.Atti to 'ospite'@'localhost';
grant select on operaDB.Libretto to 'ospite'@'localhost';
grant select on operaDB.Orchestra to 'ospite'@'localhost';
grant select on operaDB.Suona to 'ospite'@'localhost';
grant select on operaDB.Opera to 'ospite'@'localhost';
grant select on operaDB.Scena to 'ospite'@'localhost';

# -- Privilegi gestore

grant select on operaDB.* to 'gestore'@'localhost';
grant insert on operaDB.* to 'gestore'@'localhost';
grant delete on operaDB.* to 'gestore'@'localhost';
grant update on operaDB.* to 'gestore'@'localhost';

