# Experiment Configuration File Instruction
# RunQFix
parameters:
-P <portnumber>: portnumber, default 5432.
-D <database config file path>: config file path.
-s <sid>: sid
-p <pid>: pid
-N <TNAME>: initial table name
-k <0 or 1>: 0 when querylog consists non-key update queries; 1 otherwise; default 0. 

Example:
"java -Djava.library.path=/Users/xlwang/Applications/IBM/ILOG/CPLEX_Studio126/cplex/bin/x86-64_osx -jar RunQFix.jar -P 5432 -D ../dbconn.config -s 1 -p 1 -N synth -k 0"


# GenSample
parameters:
-P <portnumber>: portnumber, default 5432.
-D <database config file path>: config file path.
-s <sid>: sid
-p <pid>: pid
-N <TNAME>: initial table name
-k <0 or 1>: 0 when querylog consists non-key update queries; 1 otherwise; default 0. 
-qsize <query log size>: default 10.
-cinx <corrupt query index>: default 5, could not greater than qsize
-qcomplx <where clause cardinality>: default 1.

Example:
"java -Djava.library.path=/Users/xlwang/Applications/IBM/ILOG/CPLEX_Studio126/cplex/bin/x86-64_osx -jar GenSammple.jar -P 5432 -D ../dbconn.config -s 1 -p 1 -N synth -k 0 -qsize 10 -cinx 5 -qcomplx 1"