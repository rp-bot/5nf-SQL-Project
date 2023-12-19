CREATE TABLE Member
( 
	MemberID             char(6)  NOT NULL ,
	Name                 char(20)  NULL ,
	ContactMethod        char(20)  NULL ,
	StartDate            date  NULL ,
	EndDate              date  NULL ,
	PRIMARY KEY  CLUSTERED (MemberID ASC)
)
go

CREATE TABLE ProjectManager
( 
	MemberID             char(6)  NOT NULL ,
	NextReviewDate       date  NULL ,
	PRIMARY KEY  CLUSTERED (MemberID ASC),
	 FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
)
go

CREATE TABLE Classification
( 
	ClassID              char(1)  NOT NULL ,
	Name                 char(15)  NULL ,
	PRIMARY KEY  CLUSTERED (ClassID ASC)
)
go

CREATE TABLE Manager
( 
	MemberID             char(6)  NOT NULL ,
	LastDBLogin          datetime  NULL ,
	PRIMARY KEY  CLUSTERED (MemberID ASC),
	 FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
)
go

CREATE TABLE Region
( 
	RegionID             char(2)  NOT NULL ,
	Name                 char(11)  NULL ,
	MemberID             char(6)  NULL ,
	PRIMARY KEY  CLUSTERED (RegionID ASC),
	 FOREIGN KEY (MemberID) REFERENCES Manager(MemberID)
)
go

CREATE TABLE Farm
( 
	FarmID               char(7)  NOT NULL ,
	FarmName             char(14)  NULL ,
	Size                 int  NULL ,
	ClassID              char(1)  NULL ,
	RegionID             char(2)  NULL ,
	PRIMARY KEY  CLUSTERED (FarmID ASC),
	 FOREIGN KEY (ClassID) REFERENCES Classification(ClassID),
	 FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
)
go

CREATE TABLE Owner
( 
	MemberID             char(6)  NOT NULL ,
	FarmID               char(7)  NULL ,
	PRIMARY KEY  CLUSTERED (MemberID ASC),
	 FOREIGN KEY (FarmID) REFERENCES Farm(FarmID),
	 FOREIGN KEY (MemberID) REFERENCES Member(MemberID)
)
go

CREATE TABLE Status
( 
	Status               char(4)  NOT NULL ,
	Code                 int  NULL ,
	PRIMARY KEY  CLUSTERED (Status ASC)
)
go

CREATE TABLE Variety
( 
	Code                 char(4)  NOT NULL ,
	Description          char(20)  NULL ,
	AveYeild             decimal()  NULL ,
	PRIMARY KEY  CLUSTERED (Code ASC)
)
go

CREATE TABLE Field
( 
	FieldNum             int  NOT NULL ,
	FarmID               char(7)  NOT NULL ,
	Loc                  char(5)  NULL ,
	NumOfHarv            int  NULL ,
	PRIMARY KEY  CLUSTERED (FieldNum ASC,FarmID ASC),
	 FOREIGN KEY (FarmID) REFERENCES Farm(FarmID)
)
go

CREATE TABLE Planting
( 
	PlantDate            char(15)  NOT NULL ,
	FieldNum             int  NOT NULL ,
	FarmID               char(7)  NOT NULL ,
	Code                 char(4)  NULL ,
	PRIMARY KEY  CLUSTERED (PlantDate ASC,FieldNum ASC,FarmID ASC),
	 FOREIGN KEY (Code) REFERENCES Variety(Code),
	 FOREIGN KEY (FieldNum,FarmID) REFERENCES Field(FieldNum,FarmID)
)
go

CREATE TABLE Harvester
( 
	MemberID             char(6)  NOT NULL ,
	ClassID              char(1)  NULL ,
	PRIMARY KEY  CLUSTERED (MemberID ASC),
	 FOREIGN KEY (MemberID) REFERENCES Member(MemberID),
	 FOREIGN KEY (ClassID) REFERENCES Classification(ClassID)
)
go

CREATE TABLE Harvest
( 
	HarvestNumber        int  NOT NULL ,
	PlantDate            char(15)  NOT NULL ,
	FieldNum             int  NOT NULL ,
	FarmID               char(7)  NOT NULL ,
	HarvestDate          char(15)  NULL ,
	BushelsPerAcre       decimal()  NULL ,
	Status               char(4)  NULL ,
	MemberID             char(6)  NULL ,
	PRIMARY KEY  CLUSTERED (HarvestNumber ASC,PlantDate ASC,FieldNum ASC,FarmID ASC),
	 FOREIGN KEY (Status) REFERENCES Status(Status),
	 FOREIGN KEY (PlantDate,FieldNum,FarmID) REFERENCES Planting(PlantDate,FieldNum,FarmID),
	 FOREIGN KEY (MemberID) REFERENCES Harvester(MemberID)
)
go
