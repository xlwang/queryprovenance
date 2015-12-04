#!/bin/bash

dropdb queryprovnoise
createdb queryprovnoise
psql -f false_negative_exps.sql queryprovnoise
psql -f ../setup.ddl queryprovnoise