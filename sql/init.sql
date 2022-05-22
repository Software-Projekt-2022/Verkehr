USE verkehr;

CREATE TABLE Lots (
	LotID int NOT NULL AUTO_INCREMENT,
	AddresseID int,
	Preis varchar(255),
	Oeffnungszeiten varchar(255),
	PRIMARY KEY (LotID),
	FOREIGN KEY (AddresseID) REFERENCES Addressen(AddresseID)
);

CREATE TABLE Addressen (
	AddresseID int NOT NULL AUTO_INCREMENT,
	Strasse varchar(255),
	Hausnummer varchar(255),
	Plz int,
	KoordinateID int,
	PRIMARY KEY (AddresseID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
);

CREATE TABLE Koordinaten (
	KoordinateID int NOT NULL AUTO_INCREMENT,
	Laengengrad DECIMAL(11,8) NOT NULL,
	Breitengrad DECIMAL(10,8) NOT NULL,
	PRIMARY KEY (KoordinateID)
);


CREATE TABLE Plaetze (
	LadesaeuleID int NOT NULL AUTO_INCREMENT,
	Groesse varchar(255),
	KoordinateID int,
	P_status int,
	PRIMARY KEY (PlatzID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
);

CREATE TABLE Ladesaeulen (
	LadesaeuleID int NOT NULL AUTO_INCREMENT,
	PlatzID int,
	L_status int,
	BetriebID int,
	PRIMARY KEY (LadesaeuleID),
	FOREIGN KEY (PlatzID) REFERENCES Plaetze(PlatzID),
	FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID)
);

CREATE TABLE Betreiber (
	BetriebID int NOT NULL AUTO_INCREMENT,
	Referenz varchar(255),
	AddresseID int,
	Gewerbe_typ int,
	KoordinateID int,
	PRIMARY KEY (BetriebID),
	FOREIGN KEY (AddesseID) REFERENCES Addressen(AddresseID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
);

CREATE TABLE Spritpreise (
	SpritpreisID int NOT NULL AUTO_INCREMENT,
	S_preis FLOAT(4,3),
	Spritsorte varchar(255),
	BetriebID int,
	erzeugt_am DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (SpritpreisID),
	FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID)
);

CREATE TABLE Fahrer (
	FahrerID int NOT NULL AUTO_INCREMENT,
	BetriebID int,
	SonderUserID int,
	PRIMARY KEY (FahrerID),
	FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID),
	FOREIGN KEY (SonderUserID) REFERENCES SonderUser(SonderUserID)
);

CREATE TABLE SonderUser (
	SonderUserID int NOT NULL AUTO_INCREMENT,
	Username varchar(255),
	U_status int,
	PRIMARY KEY (SonderUserID),
);

CREATE TABLE Neuigkeiten (
	NeuigkeitID int NOT NULL AUTO_INCREMENT,
	AddresseID int,
	KoordinateID int,
	SonderUserID int,
	Meldezeit DATETIME DEFAULT CURRENT_TIMESTAMP,
	Art int,
	Beschreibung varchar(255),
	PRIMARY KEY (NeuigkeitID),
	FOREIGN KEY (AddresseID) REFERENCES Addressen(AddresseID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID),
	FOREIGN KEY (SonderUserID) REFERENCES SonderUser(SonderUserID)
);

CREATE TABLE Fahrzeuge (
	FahrzeugID int NOT NULL AUTO_INCREMENT,
	FahrerID int,
	Modell varchar(255),
	Alter int,
	Letzte_wartung DATETIME,
	Naechste_wartung DATETIME,
	in_betrieb int,
	RouteID int,
	HaltestelleID int,
	PRIMARY KEY (FahrzeugID),
	FOREIGN KEY (FahrerID) REFERENCES Fahrer(FahrerID),
	FOREIGN KEY (RouteID) REFERENCES Routen(RouteID),
	FOREIGN KEY (HaltestelleID) REFERENCES Haltestellen(HaltestelleID)
);

CREATE TABLE Route (
	RouteID int NOT NULL AUTO_INCREMENT,
	Route_name varchar(255),
	Stopps int,
	PRIMARY KEY (RouteID)
);

CREATE TABLE Haltestellen (
	HaltestelleID int NOT NULL AUTO_INCREMENT,
	KoordinateID int,
	Strasse varchar(255),
	PRIMARY KEY (HaltestelleID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
);

CREATE TABLE Routen_Haltestellen (
	RouteID int,
	StartID int,
	ZielID int,
	Anfahrt TIME,
	Abfahrt TIME,
	Fahrzeit TIME,
	FOREIGN KEY (RouteID) REFERENCES Routen(RouteID),
	FOREIGN KEY (StartID) REFERENCES Haltestellen(HaltestelleID),
	FOREIGN KEY (ZielID) REFERENCES Haltestellen(HaltestelleID)
);