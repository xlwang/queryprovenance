# Experiment Configuration File Instruction
Harness_new
- specify a configuration file including multiple lines
- each line includes parameters for *one test run*
Parameters:
 -F <filename>: (mandatory) database configuration file
 -T <tablename>: (mandatory) specify table name
 -PATH <path>: (mandatory) specify the path for querylogs, under the path, there should have two files: "gqlog", bqlog"
 -S <1/2>: 1: one pass solution; 2: two passes solution. Default: one pass solution
 -OP <0/1>: optimization choice: 0: no preprocess; 1: with preprocess
 -STEP <number>: for two passes solution only, batch rollback controlled by <number>
 -M <0/1>: for two passes solution only, 0: cplex; 1: decision tree
 -E <number>: lineariza parameter, epsilon, default: 0.0001 
 -MV <number>: linearize parameter, M, default 1000000.0
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
