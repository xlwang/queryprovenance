#!/bin/bash

dropdb queryprovmulti
createdb queryprovmulti
psql -f multierror_exps.sql queryprovmulti
psql -f ../setup.ddl queryprovmulti