# Note on Aug 11
TODO list: 
* harness: generate m queries and *m+1* database states for ds and badds; Transformation not change query structure (only numbers are allowed to change at this stage). 
(* STR type not supported in WhereExpr and SetExpr (cplex, JAMA do not support STR data type). Conversion from STR into NUM needed. ) 

# Meeting Aug 6

Code Questions 

* Don't use regular expressions to parse Strings.  Explicitly pass what you're going to parse into the constructor
--xl: I will remove most of the regular expressions by replacing the arithmetic expression in WhereClause, SetClause from "String" to "Expression". 
  * if you must, comments plz
--xl: Only for Decision Tree, we need to parse Strings from results into condition rules. All the others will be removed.  

* explain SetExpr
--xl: see comments in SetExpr. 

Status

* harness generates very simple set of queries based on Employee dataset in insert.sql
* executes, creates, and loads the databasestate for good and bad query logs
* data generator not connected with harness, so can't control dataset size/ncols etc yet
* generated queries are very simple
* Query.toString() seems to be correct


Next Steps

* Get it running
  * control which solve algorithm (simplex vs dt) to use
* evaluation metrics for now
  * db state distance
  * structural similarity
  * query log distance (in terms of query)
  * value similarity (if structures are the same)
* More expressive 
  * implement roll back function
  * incomplete complaint sets
  * multiple transformatinos
  * more complex algebraic expressions
* Faster
  * pruning the query log


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