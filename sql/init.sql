USE verkehr;

CREATE TABLE Lots (
	LotID INT NOT NULL AUTO_INCREMENT,
	Lo_AddresseID INT DEFAULT NULL,
	Preis varchar(255),
	Oeffnungszeiten varchar(255),
	PRIMARY KEY (LotID)
);

CREATE TABLE Addressen (
	AddresseID INT NOT NULL AUTO_INCREMENT,
	Strasse varchar(255),
	Hausnummer varchar(255),
	Plz INT,
	Ad_KoordinateID INT DEFAULT NULL,
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
	Pl_KoordinateID INT DEFAULT NULL,
	P_status INT,
	PRIMARY KEY (PlatzID)
);

CREATE TABLE Ladesaeulen (
	LadesaeuleID INT NOT NULL AUTO_INCREMENT,
	La_PlatzID INT DEFAULT NULL,
	L_status INT,
	La_BetriebID INT DEFAULT NULL,
	PRIMARY KEY (LadesaeuleID)
);

CREATE TABLE Betreiber (
	BetriebID INT NOT NULL AUTO_INCREMENT,
	Referenz varchar(255),
	Be_AddresseID INT DEFAULT NULL,
	Gewerbe_typ INT,
	Be_KoordinateID INT DEFAULT NULL,
	PRIMARY KEY (BetriebID)
);

CREATE TABLE Spritpreise (
	SpritpreisID INT NOT NULL AUTO_INCREMENT,
	Sp_preis FLOAT(4,3),
	Spritsorte varchar(255),
	Sp_BetriebID INT DEFAULT NULL,
	erzeugt_am DATETIME DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (SpritpreisID)
);

CREATE TABLE Fahrer (
	FahrerID INT NOT NULL AUTO_INCREMENT,
	Fa_BetriebID INT DEFAULT NULL,
	Fa_SonderUserID INT DEFAULT NULL,
	PRIMARY KEY (FahrerID)
);

CREATE TABLE SonderUser (
	SonderUserID INT NOT NULL AUTO_INCREMENT,
	Username varchar(255),
	U_status INT DEFAULT NULL,
	PRIMARY KEY (SonderUserID)
);

CREATE TABLE Neuigkeiten (
	NeuigkeitID INT NOT NULL AUTO_INCREMENT,
	Ne_AddresseID INT DEFAULT NULL,
	Ne_KoordinateID INT DEFAULT NULL,
	Ne_SonderUserID INT DEFAULT NULL,
	Meldezeit DATETIME DEFAULT CURRENT_TIMESTAMP,
	Art INT,
	Beschreibung varchar(255),
	PRIMARY KEY (NeuigkeitID)
);

CREATE TABLE Fahrzeuge (
	FahrzeugID INT NOT NULL AUTO_INCREMENT,
	Fa_FahrerID INT DEFAULT NULL,
	Modell varchar(255),
	Baujahr DATE,
	Letzte_wartung DATETIME,
	Naechste_wartung DATETIME,
	in_betrieb INT,
	RouteID INT DEFAULT NULL,
	Fa_HaltestelleID INT DEFAULT NULL,
	PRIMARY KEY (FahrzeugID)
);

CREATE TABLE Routen (
	RouteID INT NOT NULL AUTO_INCREMENT,
	Route_name varchar(255),
	Stopps INT,
	PRIMARY KEY (RouteID)
);

CREATE TABLE Haltestellen (
	HaltestelleID INT NOT NULL AUTO_INCREMENT,
	Ha_KoordinateID INT DEFAULT NULL,
	Strasse varchar(255),
	PRIMARY KEY (HaltestelleID)
);

CREATE TABLE Routen_Haltestellen (
	RH_RouteID INT NOT NULL,
	RH_StartID INT NOT NULL,
	RH_ZielID INT NOT NULL,
	Anfahrt TIME,
	Abfahrt TIME,
	Fahrzeit TIME,
	PRIMARY KEY (RH_RouteID, RH_StartID, RH_ZielID), 
	FOREIGN KEY (RH_RouteID) REFERENCES Routen(RouteID),
	FOREIGN KEY (RH_StartID) REFERENCES Haltestellen(HaltestelleID),
	FOREIGN KEY (RH_ZielID) REFERENCES Haltestellen(HaltestelleID)
);

CREATE TABLE Lots_Plaetze (
	LP_PlatzID INT NOT NULL,
	LP_LotID INT NOT NULL,
	PRIMARY KEY (LP_PlatzID, LP_LotID),
	FOREIGN KEY (LP_PlatzID) REFERENCES Plaetze(PlatzID),
	FOREIGN KEY (LP_LotID) REFERENCES Lots(LotID)
	
);

ALTER Table Lots 
ADD CONSTRAINT fk_Lo_AddresseID 
FOREIGN KEY (Lo_AddresseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Addressen 
ADD CONSTRAINT fk_Ad_KoordinateID 
FOREIGN KEY (Ad_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Plaetze 
ADD CONSTRAINT fk_Pl_KoordinateID 
FOREIGN KEY (Pl_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Ladesaeulen 
ADD CONSTRAINT fk_La_PlatzID 
FOREIGN KEY (La_PlatzID) REFERENCES Plaetze(PlatzID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Ladesaeulen 
ADD CONSTRAINT fk_La_BetriebID 
FOREIGN KEY (La_BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Betreiber
ADD CONSTRAINT fa_Be_AddresseID 
FOREIGN KEY (Be_AddesseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Betreiber 
ADD CONSTRAINT fk_Be_KoordinateID 
FOREIGN KEY (Be_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Spritpreise 
ADD CONSTRAINT fk_Sp_BetriebID 
FOREIGN KEY (Sp_BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrer 
ADD CONSTRAINT fk_Fa_BetriebID 
FOREIGN KEY (Fa_BetriebID) REFERENCES Betreiber(BetriebID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrer
ADD CONSTRAINT fk_Fa_SonderUserID 
FOREIGN KEY (Fa_SonderUserID) REFERENCES SonderUser(SonderUserID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten 
ADD CONSTRAINT fk_Ne_AddresseID 
FOREIGN KEY (Ne_AddresseID) REFERENCES Addressen(AddresseID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten
ADD CONSTRAINT fk_Ne_KoordinateID 
FOREIGN KEY (Ne_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Neuigkeiten 
ADD CONSTRAINT fk_Ne_SonderUserID 
FOREIGN KEY (Ne_SonderUserID) REFERENCES SonderUser(SonderUserID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge 
ADD CONSTRAINT fk_Fa_FahrerID 
FOREIGN KEY (Fa_FahrerID) REFERENCES Fahrer(FahrerID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge
ADD CONSTRAINT fk_Fa_RouteID 
FOREIGN KEY (Fa_RouteID) REFERENCES Routen(RouteID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Fahrzeuge 
ADD CONSTRAINT fk_Fa_HaltestelleID 
FOREIGN KEY (Fa_HaltestelleID) REFERENCES Haltestellen(HaltestelleID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

ALTER Table Haltestellen 
ADD CONSTRAINT fk_Ha_KoordinateID 
FOREIGN KEY (Ha_KoordinateID) REFERENCES Koordinaten(KoordinateID)
	ON DELETE SET NULL
	ON UPDATE SET NULL;

