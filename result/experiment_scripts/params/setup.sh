#!/bin/bash

dropdb queryprovparams
createdb queryprovparams
psql -f paramallvsparamsingle_exps.sql queryprovparams
psql -f ../setup.ddl queryprovparams