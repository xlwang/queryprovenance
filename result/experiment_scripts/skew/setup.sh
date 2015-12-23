#!/bin/bash

dropdb queryprovskew
createdb queryprovskew
psql -f skew.sql queryprovskew
psql -f ../setup.ddl queryprovskew