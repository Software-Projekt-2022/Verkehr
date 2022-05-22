USE verkehr;

CREATE TABLE Lots (
	LotID INT NOT NULL AUTO_INCREMENT,
	AddresseID INT,
	Preis varchar(255),
	Oeffnungszeiten varchar(255),
	PRIMARY KEY (LotID),
	FOREIGN KEY (AddresseID) REFERENCES Addressen(AddresseID)
);

CREATE TABLE Addressen (
	AddresseID INT NOT NULL AUTO_INCREMENT,
	Strasse varchar(255),
	Hausnummer varchar(255),
	Plz INT,
	KoordinateID INT,
	PRIMARY KEY (AddresseID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
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
	KoordinateID INT,
	P_status INT,
	PRIMARY KEY (PlatzID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
);

CREATE TABLE Ladesaeulen (
	LadesaeuleID INT NOT NULL AUTO_INCREMENT,
	PlatzID INT,
	L_status INT,
	BetriebID INT,
	PRIMARY KEY (LadesaeuleID),
	FOREIGN KEY (PlatzID) REFERENCES Plaetze(PlatzID),
	FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID)
);

CREATE TABLE Betreiber (
	BetriebID INT NOT NULL AUTO_INCREMENT,
	Referenz varchar(255),
	AddresseID INT,
	Gewerbe_typ INT,
	KoordinateID INT,
	PRIMARY KEY (BetriebID),
	FOREIGN KEY (AddesseID) REFERENCES Addressen(AddresseID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
);

CREATE TABLE Spritpreise (
	SpritpreisID INT NOT NULL AUTO_INCREMENT,
	S_preis FLOAT(4,3),
	Spritsorte varchar(255),
	BetriebID INT,
	erzeugt_am DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (SpritpreisID),
	FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID)
);

CREATE TABLE Fahrer (
	FahrerID INT NOT NULL AUTO_INCREMENT,
	BetriebID INT,
	SonderUserID INT,
	PRIMARY KEY (FahrerID),
	FOREIGN KEY (BetriebID) REFERENCES Betreiber(BetriebID),
	FOREIGN KEY (SonderUserID) REFERENCES SonderUser(SonderUserID)
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
	PRIMARY KEY (NeuigkeitID),
	FOREIGN KEY (AddresseID) REFERENCES Addressen(AddresseID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID),
	FOREIGN KEY (SonderUserID) REFERENCES SonderUser(SonderUserID)
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
	PRIMARY KEY (FahrzeugID),
	FOREIGN KEY (FahrerID) REFERENCES Fahrer(FahrerID),
	FOREIGN KEY (RouteID) REFERENCES Routen(RouteID),
	FOREIGN KEY (HaltestelleID) REFERENCES Haltestellen(HaltestelleID)
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
	PRIMARY KEY (HaltestelleID),
	FOREIGN KEY (KoordinateID) REFERENCES Koordinaten(KoordinateID)
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