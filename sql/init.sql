USE verkehr;

CREATE TABLE Lots (
	LotID INT NOT NULL AUTO_INCREMENT,
	AddresseID INT,
	Preis varchar(255),
	Oeffnungszeiten varchar(255),
	PRIMARY KEY (LotID)
);

CREATE TABLE Addressen (
	AddresseID INT NOT NULL AUTO_INCREMENT,
	Strasse varchar(255),
	Hausnummer varchar(255),
	Plz INT,
	KoordinateID INT,
	PRIMARY KEY (AddresseID)
);

CREATE TABLE Koordinaten (
	KoordinateID INT NOT NULL AUTO_INCREMENT,
	Laengengrad DECIMAL(11,8) NOT NULL,
	Breitengrad DECIMAL(10,8) NOT NULL,
	PRIMARY KEY (KoordinateID)
);


CREATE TABLE Plaetze (
	LadesaeuleID INT NOT NULL AUTO_INCREMENT,
	Groesse varchar(255),
	KoordinateID INT,
	P_status INT,
	PRIMARY KEY (PlatzID)
);

CREATE TABLE Ladesaeulen (
	LadesaeuleID INT NOT NULL AUTO_INCREMENT,
	PlatzID INT,
	L_status INT,
	BetriebID INT,
	PRIMARY KEY (LadesaeuleID)
);

CREATE TABLE Betreiber (
	BetriebID INT NOT NULL AUTO_INCREMENT,
	Referenz varchar(255),
	AddresseID INT,
	Gewerbe_typ INT,
	KoordinateID INT,
	PRIMARY KEY (BetriebID)
);

CREATE TABLE Spritpreise (
	SpritpreisID INT NOT NULL AUTO_INCREMENT,
	S_preis FLOAT(4,3),
	Spritsorte varchar(255),
	BetriebID INT,
	erzeugt_am DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (SpritpreisID)
);

CREATE TABLE Fahrer (
	FahrerID INT NOT NULL AUTO_INCREMENT,
	BetriebID INT,
	SonderUserID INT,
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
	AddresseID INT,
	KoordinateID INT,
	SonderUserID INT,
	Meldezeit DATETIME DEFAULT CURRENT_TIMESTAMP,
	Art INT,
	Beschreibung varchar(255),
	PRIMARY KEY (NeuigkeitID)
);

CREATE TABLE Fahrzeuge (
	FahrzeugID INT NOT NULL AUTO_INCREMENT,
	FahrerID INT,
	Modell varchar(255),
	Baujahr DATE DEFAULT,
	Letzte_wartung DATETIME,
	Naechste_wartung DATETIME,
	in_betrieb INT,
	RouteID INT,
	HaltestelleID INT,
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
	KoordinateID INT,
	Strasse varchar(255),
	PRIMARY KEY (HaltestelleID)
);

CREATE TABLE Routen_Haltestellen (
	RouteID INT,
	StartID INT,
	ZielID INT,
	Anfahrt TIME,
	Abfahrt TIME,
	Fahrzeit TIME,
	FOREIGN KEY (RouteID) REFERENCES Routen(RouteID),
	FOREIGN KEY (StartID) REFERENCES Haltestellen(HaltestelleID),
	FOREIGN KEY (ZielID) REFERENCES Haltestellen(HaltestelleID)
);

ALTER Table Lots 
ADD CONSTRAINT AddresseID 
FOREIGN KEY (AddresseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Addressen 
ADD CONSTRAINT KoordinateID 
FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Plaetze 
ADD CONSTRAINT KoordinateID 
FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Ladesaeulen 
ADD CONSTRAINT PlatzID 
FOREIGN KEY (PlatzID) REFERENCES Plaetze(PlatzID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Ladesaeulen 
ADD CONSTRAINT BetriebID 
FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Betreiber
ADD CONSTRAINT AddresseID 
FOREIGN KEY (AddesseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Betreiber 
ADD CONSTRAINT KoordinateID 
FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Spritpreise 
ADD CONSTRAINT BetriebID 
FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrer 
ADD CONSTRAINT BetriebID 
FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrer
ADD CONSTRAINT SonderUserID 
FOREIGN KEY (SonderUserID) REFERENCES SonderUser(SonderUserID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten 
ADD CONSTRAINT AddresseID 
FOREIGN KEY (AddresseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten
ADD CONSTRAINT KoordinateID 
FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten 
ADD CONSTRAINT SonderUserID 
FOREIGN KEY (SonderUserID) REFERENCES SonderUser(SonderUserID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge 
ADD CONSTRAINT FahrerID 
FOREIGN KEY (FahrerID) REFERENCES Fahrer(FahrerID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge
ADD CONSTRAINT RouteID 
FOREIGN KEY (RouteID) REFERENCES Routen(RouteID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge 
ADD CONSTRAINT HaltestelleID 
FOREIGN KEY (HaltestelleID) REFERENCES Haltestellen(HaltestelleID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Haltestellen 
ADD CONSTRAINT KoordinateID 
FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

