#!/bin/bash

#java -Djava.library.path=/data/sirrice/CPLEX_Studio1261/cplex/bin/x86-64_linux -cp ./libs/contexttoolkit-2.0.jar:./libs/cplex.jar:./libs/gson-2.3.1.jar:./libs/Jama-1.0.3.jar:./libs/json-simple-1.1.1.jar:./libs/postgresql-9.2-1002.jdbc4.jar:./libs/weka.jar:./bin queryprovenance.harness.SyntheticHarness $@
java -Djava.library.path=/data/sirrice/CPLEX_Studio1261/cplex/bin/x86-64_linux \
  -cp ./libs/contexttoolkit-2.0.jar:./libs/cplex.jar:./libs/gson-2.3.1.jar:./libs/Jama-1.0.3.jar:./libs/json-simple-1.1.1.jar:./libs/postgresql-9.2-1002.jdbc4.jar:./libs/weka.jar:./bin \
  queryprovenance.harness.$@