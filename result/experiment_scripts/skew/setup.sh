#!/bin/bash

dropdb queryprovskew
createdb queryprovskew
psql -f skewness.sql queryprovskew
psql -f ../setup.ddl queryprovskew