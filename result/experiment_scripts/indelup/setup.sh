#!/bin/bash

dropdb queryprovindel;
createdb queryprovindel
psql -f querytype.sql queryprovindel
psql -f ../setup.ddl queryprovindel