# Meeting Aug 6

Code Questions 

* Don't use regular expressions to parse Strings.  Explicitly pass what you're going to parse into the constructor
  * if you must, comments plz
* explain SetExpr

Status

* harness generates very simple set of queries based on Employee dataset in insert.sql
* executes, creates, and loads the databasestate for good and bad query logs
* Query.toString() seems to be correct


# Meeting Jul 23, 2014


Xiaolan will 

* continue working on the solvers for the different query types
* _not_ implement a SQL parser.

Eugene will work on scaffolding

TODOS

* connect databasestate to sql result set
* query -> SQL string
* Solve() parameters
  * transformation types to run on query log
  * which query uses which solve algorithm
  * parametrs for each DT/milp algorithm
  * whether to solve for SET/WHERE clause
  * preference/scoring function
* Data generation parameters
  * query type mixture
  * numebr of tuples
  * number of similar queries with similar structure
  * query log length