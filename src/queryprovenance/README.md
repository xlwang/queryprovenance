# Experiment Configuration File Instruction
Harness_new
- specify a configuration file including multiple lines
- each line includes parameters for *one test run*
Parameters:
 -F: (mandatory) database configuration file
 -T: (mandatory) specify table name
 -PATH: (mandatory) specify the path for querylogs, under the path, there should have two files: "gqlog", bqlog"
 -S: 1: one pass solution; 2: two passes solution. Default: one pass solution
 -OP: optimization choice: 0: no preprocess; 1: with preprocess
 -STEP: for two passes solution only, batch rollback
 -M: for two passes solution only, 0: cplex; 1: decision tree
 -E: lineariza parameter, epsilon, default: 0.0001 
 -MV: linearize parameter, M, default 1000000.0
 -AP: use approximation if cplex is infeasible
 -PRUNE: prone false positives

For example:
-F ./data/dbconfig -T updateCustomer -PATH ./experiment/tpcc/1 -S 1 -OP 0 … … 
-F ./data/dbconfig -T updateCustomer -PATH ./experiment/tpcc/2 -S 1 -OP 0 … …
… … 

Under the -PATH, e.g. “./experiment/tpcc/1”, there must have the following files:
gqlog: good query log
bqlog: bad query log
datapara: data generator information (all parameters use for datagen.py)
	dataset_name e.g. tpcc
	tuple amount e.g. 1000
	… …