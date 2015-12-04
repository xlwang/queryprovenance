#!/bin/bash

dropdb queryprovparams
createdb queryprovparams
psql -f paramallvsparamsingle.sql queryprovparams
psql -f ../setup.ddl queryprovparams