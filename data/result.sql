
drop table Result cascade;



CREATE TABLE Result(
   ID INT PRIMARY KEY     NOT NULL,
   compaintpercentage real,
   solver varchar(10),
   cardinality int,
   logsize int,
   dbsize int,
   badcomplaints int,
   remaincomplaints int,
   fixedrate real,
   noiserate real,
   badqueryindex int,
   fixedqueryindex int,
   origclausesize int,
   fixedclausesize int,
   preptime int,
   solvetime int,
   finishtime int,
   totaltime int
);
