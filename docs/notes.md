# Timeline

Jan 28

* have experimental setup down
  * dataset
    * confer didn't keep logs :(
    * anonymized grading system?
  * how to run complaint generation and noise
* SQL-based bipartite
* Wu pass at paper

Feb 1st

* Start paper.  draft by Feb 15

Feb 4

* done:
  * theorem for max-density-finding algorithm
* Experiments designed

Feb 11

* Draft of paper without experiments
* Running experiments


TODOs

* better complaints gen
* experiments
* ask anant for query logs
* multi-query case
* why do we do well for false negatives?
  * when would it fail?
  * assume complaints are uniformly sampled
    * suggests pushing verizon use case example
  * if not, then no guarantees?
* argument for cleaning FP instead of embedding in algorithm?
* Which complaints are most important?


# Meeting Feb 18

Eugene:

* get data from anant
* design synthetic experiments

Xiaolan

* write up density
* implement constraint-based rollback
  * exhaustive and greedy

Meliou

* write

# Meeting Feb 11

TODOS

* Xiaolan
  * make rollback work for constrained types of errors SET, WHERE 
* Wu add more fluff to paper
  * jot down density and optimization ideas

# Meeting Feb 4

TODOs

* Xiaolan
  * region algorithm
  * intermediate state
* Eugene
  * talk to conquer
  * make up experimental section


# Meeting Jan 29

* false positives density-based algorithm
  * O(# complaints) algorithm for computing best density subgraph in bipartite tuple-complaint graph
* write the experimental section with fake graphs

# Meeting Dec 3

Summary

* Last week, talked about order of complaints to use to resize bounding box based on distance to boundary
* looked at approximation approach can't find approximation ratio (err possibly unbounded)

Basic bounding box alg

* for each complaint
  * figure out solutions for each edge (predicate clause)
* three scores to "prioritize" each complaint in the set
  * distance from each edge.  Prioritize further ones.
  * variance of distances of complaint from each edge (higher the better)
  * density of complaints in the neighborhood.  The more neighbors the better.
* maybe works for positive and negative complaints
* asked to extend to false pos and negs
* too many parameters for the scores
  * ideally a simplier model that nicely captures them

# Meeting Oct 15

Agenda

* talk about complete set graphs
* talk about incomplete set graphs
  * why does quality and totaltime not degrade propotionally with incompleteness?
* talk about incomplete complaint sets

Summary

* make sure each solver uses same data
* rerun with smaller complaint set because CPLEX should
  * drop in quality
  * prefer later queries in the log (diffidx < 0)
* added two new solvers
  * directly compute bounding boxes of the complaint sets 
    but computing min/maxes should be much faster than simplex, though less accurate.  
    Worth comparing
  * above may be equivalent to the cplex solver
  * Density based post-processing step
    * assuming incomplete complaint set is a uniform sample of unknown percentage
    * for each edge in the query bounding box, sample the density of tuples outside the edge
    * if the density is high, then we should have a lot of examples, and less likely to expand in that direction
    * if density is low, our sample may have missed tuples in that direction, and expanding may be a good idea
    * there should be a ~closed form formulation to this problem
* Talked about supporting multiple errors
  * if we recieve multiple distinct complaint sets, they could be
    * part of the same error
    * or of a different error
  * how to support disjunctions?
    * for N complaint sets, and Q queries in the log, is it an Q^N problem?
  * streaming version where complaint sets come in a streaming fashion

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