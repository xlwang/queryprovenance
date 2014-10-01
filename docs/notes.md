# Meeting Sep 24

1. #bad_complaints avg number of complaints over 100 runs
2. #fixedcomplaints number of compaints not fixed.  should be 0
3. fix rate: # fixed / #bad
4. noise_rate: # extra complaints that were introduced by the fixes
5. prep-time: time to create the problem in ms
6. solve_time: solver time


# Meeting Aug 13

Cplex returns wrong results for >1 clause WHERE predicates
* why?
* if it is incorrect
  * need metric for how incorrect
    * diff = diff fixed database state and correct state
    * diff intersect complaint set
    * diff - complaint set
  * can incorrect solution be estimated?
    * any signals?
* speed
* define a test table schema for collecting statistics

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
  * db state distances 
    * (errors in fixed) intersect (errors in bad)
    * (errors in fixed) - (errors in bad)
    * (errors in bad) - (errors in fixed)
  * structural similarity for each query in query log
    * number of clauses different
    * string edit (e.g., jaccard) distance
  * value similarity (if structures are the same)
  * query log distance 
    * number of queries the same / total number of queries
    * should be <= 1 for now
* Experiment parameters
  * query type (delete vs update) mixture
  * number of tuples (1, 10, 100, 1000, 5000)
  * query log length
  * % of similar queries with similar structure

Steps for later

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