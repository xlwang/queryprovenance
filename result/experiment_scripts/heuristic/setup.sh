#!/bin/bash

dropdb queryprovheuristic
createdb queryprovheuristic
psql -f heuristic.sql queryprovheuristic
psql -f ../setup.ddl queryprovheuristic