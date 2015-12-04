#!/bin/bash

dropdb queryprovlog; createdb queryprovlog
psql -f logsize_exps.sql queryprovlog
psql -f ../setup.ddl queryprovlog