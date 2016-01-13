#!/bin/bash

dropdb queryprovtatp
createdb queryprovtatp
psql -f tatp.sql queryprovtatp
psql -f ../setup.ddl queryprovtatp

dropdb queryprovtpcc
createdb queryprovtpcc
psql -f tpcc_exps.sql queryprovtpcc
psql -f ../setup.ddl queryprovtpcc