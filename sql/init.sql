USE verkehr;

CREATE TABLE Lots (
	LotID INT NOT NULL AUTO_INCREMENT,
	Lo_AddresseID INT,
	Preis varchar(255),
	Oeffnungszeiten varchar(255),
	PRIMARY KEY (LotID)
);

CREATE TABLE Addressen (
	AddresseID INT NOT NULL AUTO_INCREMENT,
	Strasse varchar(255),
	Hausnummer varchar(255),
	Plz INT,
	Ad_KoordinateID INT,
	PRIMARY KEY (AddresseID)
);

CREATE TABLE Koordinaten (
	KoordinateID INT NOT NULL AUTO_INCREMENT,
	Laengengrad DECIMAL(11,8) NOT NULL,
	Breitengrad DECIMAL(10,8) NOT NULL,
	PRIMARY KEY (KoordinateID)
);


CREATE TABLE Plaetze (
	PlatzID INT NOT NULL AUTO_INCREMENT,
	Groesse varchar(255),
	Pl_KoordinateID INT,
	P_status INT,
	PRIMARY KEY (PlatzID)
);

CREATE TABLE Ladesaeulen (
	LadesaeuleID INT NOT NULL AUTO_INCREMENT,
	La_PlatzID INT,
	L_status INT,
	La_BetriebID INT,
	PRIMARY KEY (LadesaeuleID)
);

CREATE TABLE Betreiber (
	BetriebID INT NOT NULL AUTO_INCREMENT,
	Referenz varchar(255),
	Be_AddresseID INT,
	Gewerbe_typ INT,
	Be_KoordinateID INT,
	PRIMARY KEY (BetriebID)
);

CREATE TABLE Spritpreise (
	SpritpreisID INT NOT NULL AUTO_INCREMENT,
	Sp_preis FLOAT(4,3),
	Spritsorte varchar(255),
	Sp_BetriebID INT,
	erzeugt_am DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (SpritpreisID)
);

CREATE TABLE Fahrer (
	FahrerID INT NOT NULL AUTO_INCREMENT,
	Fa_BetriebID INT,
	Fa_SonderUserID INT,
	PRIMARY KEY (FahrerID)
);

CREATE TABLE SonderUser (
	SonderUserID INT NOT NULL AUTO_INCREMENT,
	Username varchar(255),
	U_status INT,
	PRIMARY KEY (SonderUserID)
);

CREATE TABLE Neuigkeiten (
	NeuigkeitID INT NOT NULL AUTO_INCREMENT,
	Ne_AddresseID INT,
	Ne_KoordinateID INT,
	Ne_SonderUserID INT,
	Meldezeit DATETIME DEFAULT CURRENT_TIMESTAMP,
	Art INT,
	Beschreibung varchar(255),
	PRIMARY KEY (NeuigkeitID)
);

CREATE TABLE Fahrzeuge (
	FahrzeugID INT NOT NULL AUTO_INCREMENT,
	Fa_FahrerID INT,
	Modell varchar(255),
	Baujahr DATE,
	Letzte_wartung DATETIME,
	Naechste_wartung DATETIME,
	in_betrieb INT,
	Fa_RouteID INT,
	Fa_HaltestelleID INT,
	PRIMARY KEY (FahrzeugID)
);

CREATE TABLE Route (
	RouteID INT NOT NULL AUTO_INCREMENT,
	Route_name varchar(255),
	Stopps INT,
	PRIMARY KEY (RouteID)
);

CREATE TABLE Haltestellen (
	HaltestelleID INT NOT NULL AUTO_INCREMENT,
	Ha_KoordinateID INT,
	Strasse varchar(255),
	PRIMARY KEY (HaltestelleID)
);

CREATE TABLE Routen_Haltestellen (
    RH_RouteID INT,
    RH_StartID INT,
    RH_ZielID INT,
    Anfahrt TIME,
    Abfahrt TIME,
    Fahrzeit TIME,
    PRIMARY KEY (RH_RouteID, RH_StartID, RH_ZielID)
);

ALTER TABLE Routen_Haltestellen
ADD CONSTRAINT RH_RouteID 
FOREIGN KEY (RH_RouteID) REFERENCES Routen(RouteID)
    ON DELETE SET NULL
    ON UPDATE SET NULL;

ALTER TABLE Routen_Haltestellen
ADD CONSTRAINT RH_StartID 
FOREIGN KEY (RH_StartID) REFERENCES Haltestellen(HaltestelleID)
    ON DELETE SET NULL
    ON UPDATE SET NULL;

ALTER TABLE Routen_Haltestellen
ADD CONSTRAINT RH_ZielID 
FOREIGN KEY (RH_ZielID) REFERENCES Haltestellen(HaltestelleID)
    ON DELETE SET NULL
    ON UPDATE SET NULL;

ALTER Table Lots 
ADD CONSTRAINT Lo_AddresseID 
FOREIGN KEY (Lo_AddresseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Addressen 
ADD CONSTRAINT Ad_KoordinateID 
FOREIGN KEY (Ad_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Plaetze 
ADD CONSTRAINT Pl_KoordinateID 
FOREIGN KEY (Pl_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Ladesaeulen 
ADD CONSTRAINT La_PlatzID 
FOREIGN KEY (La_PlatzID) REFERENCES Plaetze(PlatzID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Ladesaeulen 
ADD CONSTRAINT La_BetriebID 
FOREIGN KEY (La_BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Betreiber
ADD CONSTRAINT Be_AddresseID 
FOREIGN KEY (Be_AddesseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Betreiber 
ADD CONSTRAINT Be_KoordinateID 
FOREIGN KEY (Be_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Spritpreise 
ADD CONSTRAINT Sp_BetriebID 
FOREIGN KEY (Sp_BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrer 
ADD CONSTRAINT Fa_BetriebID 
FOREIGN KEY (Fa_BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrer
ADD CONSTRAINT Fa_SonderUserID 
FOREIGN KEY (Fa_SonderUserID) REFERENCES SonderUser(SonderUserID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten 
ADD CONSTRAINT Ne_AddresseID 
FOREIGN KEY (Ne_AddresseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten
ADD CONSTRAINT Ne_KoordinateID 
FOREIGN KEY (Ne_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten 
ADD CONSTRAINT Ne_SonderUserID 
FOREIGN KEY (Ne_SonderUserID) REFERENCES SonderUser(SonderUserID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge 
ADD CONSTRAINT Fa_FahrerID 
FOREIGN KEY (Fa_FahrerID) REFERENCES Fahrer(FahrerID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge
ADD CONSTRAINT Fa_RouteID 
FOREIGN KEY (Fa_RouteID) REFERENCES Routen(RouteID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge 
ADD CONSTRAINT Fa_HaltestelleID 
FOREIGN KEY (Fa_HaltestelleID) REFERENCES Haltestellen(HaltestelleID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Haltestellen 
ADD CONSTRAINT Ha_KoordinateID 
FOREIGN KEY (Ha_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

