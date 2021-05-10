-- SeUSE [TutorialDB]
-- Create a new table called 'Customers' in schema 'dbo'
-- Drop the table if it already exists

CREATE TABLE Shops
(
	S_name VARCHAR(255) NOT NULL,
	PRIMARY KEY(S_name)
);
GO

CREATE TABLE Products
(
	P_name VARCHAR(255) UNIQUE NOT NULL,
	Maker VARCHAR(255) NOT NULL,
	Category VARCHAR(255) NOT NULL,
	PRIMARY KEY(P_name,Maker)
);
GO

CREATE TABLE Employees
(
	E_ID VARCHAR(255) NOT NULL,
	"Name" VARCHAR(255),
	Salary float
	PRIMARY KEY(E_ID)
);
GO

CREATE TABLE Users
(
	U_ID VARCHAR(255) NOT NULL,
	"Name" VARCHAR(255) NOT NULL,
	PRIMARY KEY(U_ID)
);
GO


CREATE TABLE Orders
(
	O_ID VARCHAR(255) UNIQUE NOT NULL,
	U_ID VARCHAR(255) NOT NULL,
	Shipping_Address VARCHAR(255) NOT NULL

	FOREIGN KEY (U_ID) REFERENCES Users(U_ID),
	PRIMARY KEY(O_ID, U_ID)
);
GO

-- Create the table in the specified schema
CREATE TABLE Product_in_Shops
(
   P_name VARCHAR(255) NOT NULL,
   S_name VARCHAR(255) NOT NULL,
   Price float NOT NULL,
   Quantity int NOT NULL,
   Maker VARCHAR(255) NOT NULL,
   Category VARCHAR(255) NOT NULL,

   PRIMARY KEY(P_name, S_name, Maker),
   FOREIGN KEY (P_name,Maker) REFERENCES Products(P_name,Maker),
   FOREIGN KEY (S_name) REFERENCES Shops(S_name)

   ON UPDATE CASCADE
   ON DELETE CASCADE
);
GO


CREATE TABLE Product_in_Orders
(
   P_name VARCHAR(255) NOT NULL,
   S_name VARCHAR(255) NOT NULL,
   O_ID VARCHAR(255) NOT NULL, 
   Delivery_Date DATETIME,
   Quantity int,
   Price float,
   "Status" VARCHAR(255)NOT NULL,
   Maker VARCHAR(255)NOT NULL,
   Category VARCHAR(255)NOT NULL,
   PRIMARY KEY (P_name, S_name, O_ID, Maker),

   FOREIGN KEY (P_name,Maker) REFERENCES Products(P_name,Maker),
   FOREIGN KEY (S_name) REFERENCES Shops(S_name),
   FOREIGN KEY (O_ID) REFERENCES Orders(O_ID)

   ON UPDATE CASCADE
   ON DELETE CASCADE
);
GO

CREATE TABLE PIO_in_Orders
(
   P_name VARCHAR(255) NOT NULL,
   S_name VARCHAR(255) NOT NULL,
   O_ID VARCHAR(255) NOT NULL,
   Maker VARCHAR(255) NOT NULL,
   Date_time DATETIME,
   PRIMARY KEY (P_name, S_name, O_ID, Maker),

   FOREIGN KEY (P_name, S_name, O_ID, Maker) REFERENCES Product_in_Orders(P_name, S_name, O_ID, Maker),
   FOREIGN KEY (O_ID) REFERENCES Orders(O_ID)

   ON UPDATE CASCADE
   ON DELETE CASCADE
);
GO

CREATE TABLE PIO_Feedback_Users
(
   P_name VARCHAR(255) NOT NULL,
   U_ID VARCHAR(255) NOT NULL,
   Rating int,
   Date_time DATETIME,
   Comment VARCHAR(1000)NOT NULL,
   PRIMARY KEY (P_name, U_ID),

   FOREIGN KEY (P_name) REFERENCES Products(P_name),
   FOREIGN KEY (U_ID) REFERENCES Users(U_ID)

   ON UPDATE CASCADE
   ON DELETE CASCADE
);
GO

CREATE TABLE Complaints
(
	C_ID VARCHAR(255) NOT NULL,
	"Text" VARCHAR(255) NOT NULL,
	"Status" VARCHAR(255) NOT NULL,
	Filed_date_time DATETIME UNIQUE,
	E_ID VARCHAR(255) NOT NULL,
	U_ID VARCHAR(255) NOT NULL,
	Handled_date_time DATETIME
	PRIMARY KEY(C_ID)

	FOREIGN KEY (E_ID) REFERENCES Employees(E_ID),
	FOREIGN KEY (U_ID) REFERENCES Users(U_ID)

	ON UPDATE CASCADE
	ON DELETE CASCADE
);
GO

CREATE TABLE Price_History
(
	P_name VARCHAR(255) NOT NULL,
	S_name VARCHAR(255) NOT NULL,
	Price FLOAT NOT NULL,
	"Start_date" DATE NOT NULL,
	End_date DATE NOT NULL,
	Maker VARCHAR(255) NOT NULL,
	PRIMARY KEY(P_Name, S_name, "Start_date", Maker),

   FOREIGN KEY (P_name, Maker) REFERENCES Products(P_name, Maker),
   FOREIGN KEY (S_name) REFERENCES Shops(S_name)

   ON UPDATE CASCADE
   ON DELETE CASCADE
);
GO

CREATE TABLE Complaints_On_Shops
(
	C_ID VARCHAR(255) NOT NULL,
	Filed_date_time DATETIME,
	"Text" VARCHAR(255) NOT NULL,
	"Status" VARCHAR(255) NOT NULL,
	Handled_date_time DATETIME,
	E_ID VARCHAR(255),
	U_ID VARCHAR(255) NOT NULL,
	S_name VARCHAR(255) NOT NULL,
	PRIMARY KEY(C_ID, Filed_date_time, U_ID, E_ID),

	FOREIGN KEY (C_ID) REFERENCES Complaints(C_ID),
	FOREIGN KEY (E_ID) REFERENCES Employees(E_ID),
    FOREIGN KEY (Filed_date_time) REFERENCES Complaints(Filed_date_time),
	FOREIGN KEY (U_ID) REFERENCES Users(U_ID)

   ON UPDATE CASCADE
   ON DELETE CASCADE
);
GO

CREATE TABLE Complaints_On_Orders
(
	C_ID VARCHAR(255) NOT NULL,
	Filed_date_time DATETIME,
	"Text" VARCHAR(255) NOT NULL,
	"Status" VARCHAR(255) NOT NULL,
	Handled_date_time DATETIME,
	E_ID VARCHAR(255),
	U_ID VARCHAR(255) NOT NULL,
	O_ID VARCHAR(255) NOT NULL,
	PRIMARY KEY(C_ID, Filed_date_time, U_ID),

	FOREIGN KEY (C_ID) REFERENCES Complaints(C_ID),
    FOREIGN KEY (Filed_date_time) REFERENCES Complaints(Filed_date_time),
	FOREIGN KEY (U_ID) REFERENCES Users(U_ID)

	ON UPDATE CASCADE
    ON DELETE CASCADE
);
GO
