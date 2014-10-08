
drop table Employee cascade;

CREATE TABLE Employee(
   employeeID INT PRIMARY KEY     NOT NULL,
   level INT,
   age              INT,
   employmentyear   INT,
   tax             REAL,
   salary         REAL
);

