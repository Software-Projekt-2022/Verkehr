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
	Fahrzeug_alter INT,
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
	Fahrzeit TIME
);