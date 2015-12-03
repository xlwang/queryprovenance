#!/bin/bash

dropdb queryprovrel
createdb queryprovrel
psql -f relative.sql queryprovrel
psql -f ../setup.ddl queryprovrel